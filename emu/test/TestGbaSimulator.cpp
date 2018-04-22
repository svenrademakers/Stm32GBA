#include "gtest/gtest.h"
#include "infra/MemoryRange.hpp"
#include "infra/LeanVector.hpp"
#include <array>
#include <functional>

class CPUArmv7
{
private:
    static constexpr int8_t MOV = (0b100 << 1);
    //static constexpr int8_t LSL = (0b100 << 1);
    //static constexpr int8_t LSR = (0b100 << 1);
    //static constexpr int8_t ASR = (0b100 << 1);
    //static constexpr int8_t ADD = (0b100 << 1);
    //static constexpr int8_t MOV = (0b100 << 1);


public:
    CPUArmv7() = delete;
    CPUArmv7(CPUArmv7&) = delete;
    CPUArmv7& operator =(const CPUArmv7&) = delete;

    CPUArmv7(const sx::ConstMemoryRange<uint32_t>& ROM, const sx::ConstMemoryRange<uint32_t>& RAM,
        const sx::ConstMemoryRange<uint32_t>& registers)
        : rom(ROM)
        , ram(RAM)
        , registers(registers)
    {}

    void StartExe();

private:
    const sx::ConstMemoryRange<uint32_t> rom;
    const sx::ConstMemoryRange<uint32_t> ram;
    const sx::ConstMemoryRange<uint32_t> registers;
};

void CPUArmv7::StartExe()
{
    uint32_t* currentInstruction = rom[0];
    uint8_t val = (*rom[0]) & 0xFF;
    uint8_t reg = ((*rom[0]) >> 8) & 0x0F;
    *registers[reg] = val;
}

class TestArmv7
    : public testing::Test
{
private:
    struct Hashes
    {
        uint32_t rom;
        uint32_t ram;
        uint32_t reg;
    };

public:
    TestArmv7()
        : cpu(rom, ram, registers)
    {}

protected:

    virtual void TearDown() 
    {
        auto hash = CreateHashes();
        EXPECT_EQ(HashedState.ram, hash.ram);
        EXPECT_EQ(HashedState.rom, hash.rom);
        EXPECT_EQ(HashedState.reg, hash.reg);
    }

    void HashCpu()
    {
        HashedState = CreateHashes();
    }

private:
    Hashes CreateHashes()
    {
        Hashes hashj;
        hashj.rom = hash(rom);
        hashj.ram = hash(ram);
        hashj.reg = hash(registers);
        return hashj;
    }

    unsigned hash(const sx::ConstMemoryRange<uint32_t>& chunk)
    {
        uint32_t h = 0;
        auto it = chunk.cbegin();

        while (it != chunk.cend())
            h = h * 101 + (unsigned)*it++;
        return h;
    }

protected:
    std::array<uint32_t, 20> rom = {};
    std::array<uint32_t, 20> ram = {};
    std::array<uint32_t, 15> registers = {};
    CPUArmv7 cpu;

    Hashes HashedState;
};

TEST_F(TestArmv7, write_to_register_R0)
{
    //mov.w	r0, #123
    rom[0] = 0xf04f007b;
    HashCpu();

    cpu.StartExe();
    EXPECT_EQ(registers[0], 123);
    HashedState.reg = 3695052723;
}

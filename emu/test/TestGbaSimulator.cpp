#include "gtest/gtest.h"
#include "infra/MemoryRange.hpp"
#include "infra/LeanVector.hpp"
#include <array>
#include <functional>
#include <optional>

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
    CPUArmv7(const CPUArmv7&) = delete;
    CPUArmv7& operator =(const CPUArmv7&) = delete;

    CPUArmv7(const sx::FixedMemoryRange<uint32_t>& ROM, const sx::FixedMemoryRange<uint32_t>& RAM,
        const sx::FixedMemoryRange<uint32_t>& registers)
        : rom(ROM)
        , ram(RAM)
        , registers(registers)
    {}

    void StartExe();

private:
    const sx::FixedMemoryRange<uint32_t> rom;
    const sx::FixedMemoryRange<uint32_t> ram;
    const sx::FixedMemoryRange<uint32_t> registers;
};

void CPUArmv7::StartExe()
{
    uint32_t currentInstruction = rom[0];

    if ((currentInstruction & 0xF0000000) == 0xF0000000)
        std::abort(); //UNPREDICTABLE.
    else
    {
        uint8_t val = rom[0] & 0xFF;
        uint8_t reg = (rom[0] >> 8) & 0x0F;
        registers[reg] = val;
    }
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

protected:
    void VerifyInstructions(const sx::FixedMemoryRange<uint32_t>& rom, 
        const sx::FixedMemoryRange<uint32_t>& ram,
        const sx::FixedMemoryRange<uint32_t>& registers,
        const std::function<void()> expectations)
    {
        Hashes hashj;
        hashj.rom = hash(rom);
        hashj.ram = hash(ram);
        hashj.reg = hash(registers);
        HashedState = hashj;

        cpu.emplace(rom, ram, registers);
        cpu->StartExe();

        expectations();

        hashj.rom = hash(rom);
        hashj.ram = hash(ram);
        hashj.reg = hash(registers);
        EXPECT_EQ(HashedState.ram, hashj.ram);
        EXPECT_EQ(HashedState.rom, hashj.rom);
        EXPECT_EQ(HashedState.reg, hashj.reg);
    }

private:
    unsigned hash(const sx::FixedMemoryRange<uint32_t>& chunk)
    {
        uint32_t h = 0;
        auto it = chunk.cbegin();

        while (it != chunk.cend())
            h = h * 101 + (unsigned)*it++;
        return h;
    }

protected:
    std::optional<CPUArmv7> cpu;

    Hashes HashedState;
};

TEST_F(TestArmv7, write_to_register_R0)
{
    //mov     r0, #123
    const std::array<uint32_t, 1> rom{ 0xe3a0007b };
    const std::array<uint32_t, 1> ram{};
    const std::array<uint32_t, 3> reg{};

    VerifyInstructions(rom, ram, reg, [&]() {
        EXPECT_EQ(reg[0], 123);
        HashedState.reg = 1254723;
    });
}

TEST_F(TestArmv7, unpredictable_condition_field)
{
    // condition field set to 0b1111
    const std::array<uint32_t, 1> rom{ 0xF3a0007b };
    const std::array<uint32_t, 1> ram{};
    const std::array<uint32_t, 3> reg{};
    EXPECT_EXIT({ VerifyInstructions(rom, ram, reg, []() {}); }, ::testing::ExitedWithCode(3), "");
}
//
//
//TEST_F(TestArmv7, write_to_register_R0_thumb)
//{
//    //movs    r0, #123; 0x7b
//    rom[0] = 0x207b;
//    HashCpu();
//
//    cpu.StartExe();
//    EXPECT_EQ(registers[0], 123);
//    HashedState.reg = 3695052723;
//}

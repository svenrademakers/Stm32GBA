#include <array>
#include <functional>
#include <optional>
#include <iostream>
#include <vector>
#include <fstream>
#include <iostream>

#include "gtest/gtest.h"
#include "infra/MemoryRange.hpp"
#include "infra/LeanVector.hpp"
#include "platform/FileSystemImpl.hpp"
#include "GbaEmulator.hpp"

namespace
{
    std::vector<uint32_t> GetGame()
    {
        sx::FileSystemImpl fs;
        return fs.ReadBinary("C:\\Users\\Sven\\Documents\\stixxEmulator\\emu\\test\\zelda.GBA");
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

        cpu.emplace(game, ram, registers);
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

    static const std::vector<uint32_t> game;
};

const std::vector<uint32_t> TestArmv7::game = GetGame();

//TEST_F(TestArmv7, write_to_register_R0)
//{
//    //mov     r0, #123
//    const std::array<uint32_t, 1> rom{ 0xe3a0007b };
//    const std::array<uint32_t, 1> ram{};
//    const std::array<uint32_t, 3> reg{};
//
//    VerifyInstructions(rom, ram, reg, [&]() {
//        EXPECT_EQ(reg[0], 123);
//        HashedState.reg = 1254723;
//    });
//}
//
//TEST_F(TestArmv7, unpredictable_condition_field)
//{
//    // condition field set to 0b1111
//    const std::array<uint32_t, 1> rom{ 0xF3a0007b };
//    const std::array<uint32_t, 1> ram{};
//    const std::array<uint32_t, 3> reg{};
//    EXPECT_EXIT({ VerifyInstructions(rom, ram, reg, []() {}); }, ::testing::ExitedWithCode(3), "");
//}

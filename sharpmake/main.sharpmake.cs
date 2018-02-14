using System.IO;
using Sharpmake;

[Generate]
class GBAEmu : Solution
{
    public GBAEmu()
	{
        AddTargets(new Target(
            Platform.win32 | Platform.win64,
            DevEnv.vs2015,
            Optimization.Debug | Optimization.Release));
    }

    [Configure]
    public void ConfigureAll(Solution.Configuration conf, Target target)
    {
        conf.SolutionPath = @"[solution.SharpmakeCsPath]\..\build_vs";
        conf.AddProject<GBAEmu_Application>(target);
    }
	
	[Main]
	public static void SharpmakeMain(Arguments sharpmakeArgs)
	{
		sharpmakeArgs.Generate<GBAEmu>();
	}
}

[Generate]
class GBAEmu_Application : Project
{
    public GBAEmu_Application()
    {
        SourceRootPath = @"[project.SharpmakeCsPath]\..";

        AddTargets(new Target(
            Platform.win32 | Platform.win64,
            DevEnv.vs2015,
            Optimization.Debug | Optimization.Release));
    }
	
	[Configure]
	public void ConfigureAll(Project.Configuration conf, Target target)
	{
        conf.ProjectPath = @"[project.SharpmakeCsPath]\..\build_vs";
	}
}
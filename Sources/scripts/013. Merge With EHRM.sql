
alter proc spMergeWithHRM
as
begin
	
	/* FileManager */
	exec spMergeArchiveDeptWithHRM
	exec spMergeArchiveBranchWithHRM
	exec spMergeArchiveDesignationWithHRM
	exec spMergeArchiveEmpListWithHRM

	/*HelpDesk*/
	exec spMergemDeskDesignationWithHRM
	exec spMergemDeskDeptWithHRM
	exec spMergemDeskBranchWithHRM
	exec spMergemDeskEmpListWithHRM

end
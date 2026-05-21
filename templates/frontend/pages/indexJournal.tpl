{**
 * templates/frontend/pages/indexJournal.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the index page for a journal
 *
 * @uses $currentJournal Journal This journal
 * @uses $journalDescription string Journal description from HTML text editor
 * @uses $homepageImage object Image to be displayed on the homepage
 * @uses $additionalHomeContent string Arbitrary input from HTML text editor
 * @uses $announcements array List of announcements
 * @uses $numAnnouncementsHomepage int Number of announcements to display on the
 *       homepage
 * @uses $issue Issue Current issue
 *}
{if $currentJournal->getPath() == 'mpr' || $currentJournal->getPath() == 'mber' || $currentJournal->getPath() == 'mer' || $currentJournal->getPath() == 'isr'}
	{include file="frontend/components/header.tpl" pageTitleTranslated=$currentJournal->getLocalizedName()}

	{if $homepageImage}
		<div class="homepage-image{if $issue} homepage-image-behind-issue{/if}">
			<div style=""></div>
		</div>
	{/if}

	<div class="container container-homepage-issue-mpr">
		<div class="row">
			<!-- Main content (left side) -->
			<div class="col-lg-9 col-12 main-content-mpr">
				{if $issue}
					<div class="header-wrapper-tes">
						<div class="row header-row d-flex justify-content-between align-items-center flex-sm-row">

							{if $issue->getLocalizedCoverImageUrl()}
								<div class="col-md-8 left-content">
							{else}
								<div class="col-12">
							{/if}
								<div class="homepage-issue-wrapper">
									<h2 class="h5 homepage-issue-current">
										{translate key="journal.currentIssue"}
									</h2>
									<div class="h1 homepage-issue-identifier">
										{$issue->getIssueSeries()|escape}
									</div>
									<div class="h6 homepage-issue-published">
										{translate key="plugins.themes.healthSciences.currentIssuePublished" date=$issue->getDatePublished()|date_format:$dateFormatLong}
									</div>
								</div>
								{if $issue->hasDescription() || $issueGalleys}
									{if $issue->hasDescription() || $journalDescription || $issueGalleys}
										<div class="">
											<div class="homepage-issue-description-wrapper mpr">
												{if $issue->hasDescription()}
													<div class="homepage-issue-description">
														<div class="h2">
															{if $issue->getLocalizedTitle()}
																{$issue->getLocalizedTitle()|escape}
															{else}
																{translate key="plugins.themes.healthSciences.issueDescription"}
															{/if}
														</div>
														<div class="description">{$issue->getLocalizedDescription()|strip_unsafe_html}
														</div>
														<div class="homepage-issue-description-more">
															<a href="{url op="view" page="issue" path=$issue->getBestIssueId()}">{translate key="common.more"}</a>
														</div>
													</div>
												{elseif $journalDescription}
													<div class="homepage-journal-description long-text" id="homepageDescription">
														{$journalDescription|strip_unsafe_html}
													</div>
													<div class="homepage-description-buttons hidden" id="homepageDescriptionButtons">
														<a class="homepage-journal-description-more hidden" id="homepageDescriptionMore">{translate key="common.more"}</a>
														<a class="homepage-journal-description-less hidden" id="homepageDescriptionLess">{translate key="common.less"}</a>
													</div>
												{/if}
												{if $issueGalleys}
													<div class="homepage-issue-galleys">
														<div class="h3">
															{translate key="issue.fullIssue"}
														</div>
														{foreach from=$issueGalleys item=galley}
															{include file="frontend/objects/galley_link.tpl" parent=$issue purchaseFee=$currentJournal->getSetting('purchaseIssueFee') purchaseCurrency=$currentJournal->getSetting('currency')}
														{/foreach}
													</div>
												{/if}
											</div>
										</div>
									{/if}
								{/if}
							</div>
							<div class="col-lg-4 right-content d-flex align-items-center">
								{if $issue->getLocalizedCoverImageUrl()}
									<div class="col-md-3 img-wrapper">
										<a href="{url op="view" page="issue" path=$issue->getBestIssueId()}">
											<img class="img-fluid homepage-issue-cover {if $homepageImage && $issue->getLocalizedCoverImageUrl()}smaller-image-cover{/if}"
												src="{$issue->getLocalizedCoverImageUrl()|escape}"
												{if $issue->getLocalizedCoverImageAltText() != ''}
												alt="{$issue->getLocalizedCoverImageAltText()|escape}"{/if}>
										</a>
									</div>
								{/if}
							</div>
						</div>
					</div>

					{* display announcements before full issue *}
					{if $numAnnouncementsHomepage && $announcements|@count}
					<section class="row homepage-announcements">
						<h2 class="visually-hidden">{translate key="announcement.announcementsHome"}</h2>
						{foreach from=$announcements item=announcement}
							<article class="col-md-4 homepage-announcement">
								<h3 class="homepage-announcement-title">{$announcement->getLocalizedData('title')|escape}</h3>
								<p>{$announcement->getLocalizedData('descriptionShort')|strip_unsafe_html}
									<br>
									<a href="{url router=$smarty.const.ROUTE_PAGE page="announcement" op="view" path=$announcement->id}">
										{capture name="more" assign="more"}{translate key="common.more"}{/capture}
										{translate key="plugins.themes.healthSciences.more" text=$more}
									</a>
								</p>
								<footer>
									<small class="homepage-announcement-date">{$announcement->datePosted|date_format:$dateFormatLong}</small>
								</footer>
							</article>
						{/foreach}
					</section>
					{/if}

					<div class="row justify-content-center{if $homepageImage && $issue->hasDescription()} issue-full-data{elseif $homepageImage && $issue->getLocalizedCoverImageUrl()} issue-image-cover{elseif $homepageImage} issue-only-image{/if}">
						<div class="col-12 col-lg-12">
							{include file="frontend/objects/issue_toc.tpl" sectionHeading="h3"}
						</div>
					</div>

					<div class="text-center">
						<a class="btn" href="{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive"}">
							{translate key="journal.viewAllIssues"}
						</a>
					</div>
				{/if}

				{if $additionalHomeContent}
					<div class="row justify-content-center homepage-additional-content">
						<div class="col-lg-12">{$additionalHomeContent}</div>
					</div>
				{/if}
			</div>

			<!-- Sidebar (right side) -->
			<div class="col-lg-3 col-12 order-md-2 sidebar-wrapper">
				<div class="sidebar-block">
					<div class="mpr-sidebar-block">
						<ul>
							<li><a href="/index.php/{$currentJournal->getPath()}/about"><span class="sidebar-link-text">About the Journal</span>
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
										class="bi bi-chevron-right" viewBox="0 0 16 16">
										<path fill-rule="evenodd"
											d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708" />
									</svg></a></li>
							<li><a href="/index.php/{$currentJournal->getPath()}/scope" target="_blank"><span class="sidebar-link-text">Focus and Scope</span>
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
										class="bi bi-chevron-right" viewBox="0 0 16 16">
										<path fill-rule="evenodd"
											d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708" />
									</svg></a></li>
							<li><a href="/index.php/{$currentJournal->getPath()}/editorial-board" target="_blank"><span class="sidebar-link-text">Editorial Board</span>
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
										class="bi bi-chevron-right" viewBox="0 0 16 16">
										<path fill-rule="evenodd"
											d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708" />
									</svg></a></li>
							<li><a href="/index.php/{$currentJournal->getPath()}/peerreview" target="_blank"><span class="sidebar-link-text">Peer Review Process</span>
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
										class="bi bi-chevron-right" viewBox="0 0 16 16">
										<path fill-rule="evenodd"
											d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708" />
									</svg></a></li>
							{if $currentJournal->getPath() == 'mpr'}
							<li><a href="/index.php/{$currentJournal->getPath()}/ai-policy-for-authors" target="_blank"><span class="sidebar-link-text">AI Policy for Authors</span>
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
										class="bi bi-chevron-right" viewBox="0 0 16 16">
										<path fill-rule="evenodd"
											d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708" />
									</svg></a></li>
							{/if}
							<li><a href="/index.php/{$currentJournal->getPath()}/about/contact" target="_blank"><span class="sidebar-link-text">Contact</span>
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
										class="bi bi-chevron-right" viewBox="0 0 16 16">
										<path fill-rule="evenodd"
											d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708" />
									</svg></a></li>
						</ul>
					</div>
					{if $currentJournal->getPath() == 'mber' || $currentJournal->getPath() == 'mpr'}
						<div class="mpr-sidebar-block metrics">
							<div class="title">
								Metrics Journal
							</div>
							<ul>
								<li><a href="/index.php/{$currentJournal->getPath()}/most-downloaded-article" target="_blank"><span class="sidebar-link-text">Most Downloaded</span>
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
											class="bi bi-chevron-right" viewBox="0 0 16 16">
											<path fill-rule="evenodd"
												d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708" />
										</svg></a></li>
							</ul>
							{if $currentJournal->getPath() == 'mber'}
								<ul>
									<li><a href="/index.php/{$currentJournal->getPath()}/scopuscitation" target="_blank"><span class="sidebar-link-text">Most Cited Articles in Scopus</span>
											<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
												class="bi bi-chevron-right" viewBox="0 0 16 16">
												<path fill-rule="evenodd"
													d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708" />
											</svg></a></li>
								</ul>
							{/if}
						</div>
					{/if}
					{call_hook name="Templates::Common::Sidebar"}
				</div>
			</div>

		</div>
	</div>

	{include file="frontend/components/footer.tpl"}

{else}
	{include file="frontend/components/header.tpl" pageTitleTranslated=$currentJournal->getLocalizedName()}

	{if $homepageImage}
		<div class="homepage-image{if $issue} homepage-image-behind-issue{/if}">
			<img src="{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}" alt="{$homepageImageAltText|escape}">
		</div>
	{/if}

	<div class="container container-homepage-issue page-content">
		{if $issue}
			<h2 class="h5 homepage-issue-current">
				{translate key="journal.currentIssue"}
			</h2>
			<div class="h1 homepage-issue-identifier">
				{$issue->getIssueSeries()|escape}
			</div>
			<div class="h6 homepage-issue-published">
				{translate key="plugins.themes.healthSciences.currentIssuePublished" date=$issue->getDatePublished()|date_format:$dateFormatLong}
			</div>

			{* make the entire block conditional if there aren't any additional issue data *}
			{if $issue->getLocalizedCoverImageUrl() || $issue->hasDescription() || $issueGalleys}
				<div class="row justify-content-center homepage-issue-header">
					{if $issue->getLocalizedCoverImageUrl()}
						<div class="col-lg-3">
							<a href="{url op="view" page="issue" path=$issue->getBestIssueId()}">
								<img class="img-fluid homepage-issue-cover" src="{$issue->getLocalizedCoverImageUrl()|escape}"{if $issue->getLocalizedCoverImageAltText() != ''} alt="{$issue->getLocalizedCoverImageAltText()|escape}"{/if}>
							</a>
						</div>
					{/if}
					{if $issue->hasDescription() || $journalDescription || $issueGalleys}
						<div class="col-lg-9">
							<div class="homepage-issue-description-wrapper">
								{if $issue->hasDescription()}
									<div class="homepage-issue-description">
										<div class="h2">
											{if $issue->getLocalizedTitle()}
												{$issue->getLocalizedTitle()|escape}
											{else}
												{translate key="plugins.themes.healthSciences.issueDescription"}
											{/if}
										</div>
										{$issue->getLocalizedDescription()|strip_unsafe_html}
										<div class="homepage-issue-description-more">
											<a href="{url op="view" page="issue" path=$issue->getBestIssueId()}">{translate key="common.more"}</a>
										</div>
									</div>
								{elseif $journalDescription}
									<div class="homepage-journal-description long-text" id="homepageDescription">
										{$journalDescription|strip_unsafe_html}
									</div>
									<div class="homepage-description-buttons hidden" id="homepageDescriptionButtons">
										<a class="homepage-journal-description-more hidden" id="homepageDescriptionMore">{translate key="common.more"}</a>
										<a class="homepage-journal-description-less hidden" id="homepageDescriptionLess">{translate key="common.less"}</a>
									</div>
								{/if}
								{if $issueGalleys}
									<div class="homepage-issue-galleys">
										<div class="h3">
											{translate key="issue.fullIssue"}
										</div>
										{foreach from=$issueGalleys item=galley}
											{include file="frontend/objects/galley_link.tpl" parent=$issue purchaseFee=$currentJournal->getSetting('purchaseIssueFee') purchaseCurrency=$currentJournal->getSetting('currency')}
										{/foreach}
									</div>
								{/if}
							</div>
						</div>
					{/if}
				</div>
			{/if}

		{/if}

		{* display announcements before full issue *}
		{if $numAnnouncementsHomepage && $announcements|@count}
		<section class="row homepage-announcements">
			<h2 class="visually-hidden">{translate key="announcement.announcementsHome"}</h2>
			{foreach from=$announcements item=announcement}
				<article class="col-md-4 homepage-announcement">
					<h3 class="homepage-announcement-title">{$announcement->getLocalizedData('title')|escape}</h3>
					<p>{$announcement->getLocalizedData('descriptionShort')|strip_unsafe_html}
						<br>
						<a href="{url router=$smarty.const.ROUTE_PAGE page="announcement" op="view" path=$announcement->id}">
							{capture name="more" assign="more"}{translate key="common.more"}{/capture}
							{translate key="plugins.themes.healthSciences.more" text=$more}
						</a>
					</p>
					<footer>
						<small class="homepage-announcement-date">{$announcement->datePosted|date_format:$dateFormatLong}</small>
					</footer>
				</article>
			{/foreach}
		</section>
		{/if}

		{if $issue}
			<div class="row issue-wrapper{if $homepageImage && $issue->hasDescription()} issue-full-data{elseif $homepageImage && $issue->getLocalizedCoverImageUrl()} issue-image-cover{elseif $homepageImage} issue-only-image{/if}">
				<div class="col-12 col-lg-9">
					{include file="frontend/objects/issue_toc.tpl" sectionHeading="h3"}
				</div>
			</div>

			<div class="text-center">
				<a class="btn" href="{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive"}">
					{translate key="journal.viewAllIssues"}
				</a>
			</div>
		{/if}

		{* Additional Homepage Content *}
		{if $additionalHomeContent}
			<div class="row justify-content-center homepage-additional-content">
				<div class="col-lg-9">{$additionalHomeContent}</div>
			</div>
		{/if}
	</div><!-- .container -->

	{include file="frontend/components/footer.tpl"}
{/if}

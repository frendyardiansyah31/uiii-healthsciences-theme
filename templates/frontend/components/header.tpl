{**
 * templates/frontend/components/header.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Common frontend site header.
 *}

{* Determine whether a logo or title string is being displayed *}
{assign var="showingLogo" value=true}
{if !$displayPageHeaderLogo}
	{assign var="showingLogo" value=false}
{/if}

{capture assign="homeUrl"}
	{url page="index" router=$smarty.const.ROUTE_PAGE}
{/capture}

{* Logo or site title. Only use <h1> heading on the homepage.
	 Otherwise that should go to the page title. *}
{if $requestedOp == 'index'}
	{assign var="siteNameTag" value="h1"}
{else}
	{assign var="siteNameTag" value="div"}
{/if}

{* Determine whether to show a logo of site title *}
{capture assign="brand"}{strip}
	{if $displayPageHeaderLogo}
		<img src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}"
		     {if $displayPageHeaderLogo.altText != ''}alt="{$displayPageHeaderLogo.altText|escape}"
		     {else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if}
				 class="img-fluid">
	{elseif $displayPageHeaderTitle}
		<span class="navbar-logo-text">{$displayPageHeaderTitle|escape}</span>
	{else}
		<img src="{$baseUrl}/templates/images/structure/logo.png" alt="{$applicationName|escape}" class="img-fluid">
	{/if}
{/strip}{/capture}

<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
{if !$pageTitleTranslated}{capture assign="pageTitleTranslated"}{translate key=$pageTitle}{/capture}{/if}
{include file="frontend/components/headerHead.tpl"}
<body dir="{$currentLocaleLangDir|escape|default:"ltr"}">

{* Header *}
<header class="main-header">
{* ===== MAINTENANCE BANNER + MODAL — hapus/comment blok ini untuk menonaktifkan ===== *}
	{*<style>
		#maintenance-banner {
			background: #F59E0B;
			color: #1C1917;
			display: flex;
			align-items: center;
			justify-content: space-between;
			padding: 10px 20px;
			font-size: 14px;
			font-weight: 500;
			line-height: 1.5;
			font-family: sans-serif;
			position: sticky;
			top: 0;
			z-index: 9998;
			width: 100%;
			box-sizing: border-box;
		}
		#maintenance-banner .banner-text {
			flex: 1;
			margin-right: 16px;
		}
		#maintenance-banner .banner-btn {
			background: #1C1917;
			color: #fff;
			border: none;
			padding: 6px 16px;
			border-radius: 4px;
			font-size: 13px;
			font-weight: 600;
			cursor: pointer;
			white-space: nowrap;
			font-family: sans-serif;
		}
		#maintenance-banner .banner-btn:hover { background: #374151; }

		#maintenanceModal {
			display: none;
			position: fixed;
			inset: 0;
			background: rgba(0,0,0,0.6);
			z-index: 10000;
			align-items: center;
			justify-content: center;
			padding: 16px;
		}
		#maintenanceModal.active { display: flex; }
		#maintenanceModal .modal-box {
			background: #fff;
			border-radius: 8px;
			max-width: 560px;
			width: 100%;
			overflow: hidden;
			font-family: sans-serif;
		}
		#maintenanceModal .modal-header {
			background: #1F3864;
			color: #fff;
			padding: 16px 20px;
			font-size: 16px;
			font-weight: 700;
			line-height: 1.4;
		}
		#maintenanceModal .modal-body {
			padding: 20px;
			font-size: 14px;
			color: #1C1917;
			line-height: 1.6;
		}
		#maintenanceModal .modal-body p { margin: 0 0 12px; }
		#maintenanceModal .modal-body ul {
			margin: 4px 0 12px 20px;
			padding: 0;
		}
		#maintenanceModal .modal-body ul li { margin-bottom: 4px; }
		#maintenanceModal .modal-body .section-title {
			font-weight: 700;
			margin: 14px 0 4px;
		}
		#maintenanceModal .modal-footer {
			padding: 0 20px 20px;
		}
		#maintenanceModal .modal-confirm-btn {
			background: #1F3864;
			color: #fff;
			border: none;
			width: 100%;
			padding: 12px;
			border-radius: 4px;
			font-size: 15px;
			font-weight: 600;
			cursor: pointer;
			font-family: sans-serif;
		}
		#maintenanceModal .modal-confirm-btn:hover { background: #162a4e; }

		@media (max-width: 600px) {
			#maintenance-banner { font-size: 12px; padding: 8px 12px; }
			#maintenance-banner .banner-btn { font-size: 12px; padding: 5px 10px; }
		}
	</style>*/}

	{* BANNER *}
	{* <div id="maintenance-banner">
		<span class="banner-text">
			&#128296; <strong>System Maintenance in Progress</strong> &mdash;
			Registration and article submissions are temporarily unavailable online.
			Please contact your journal administrator via email.
		</span>
		<button class="banner-btn" onclick="openMaintenanceModal()">Learn More</button>
	</div> *}

	{* MODAL *}
	{* <div id="maintenanceModal" role="dialog" aria-modal="true" aria-labelledby="modalTitle">
		<div class="modal-box">
			<div class="modal-header" id="modalTitle">
				&#9888;&#65039; Important Notice: System Maintenance &amp; Upgrade
			</div>
			<div class="modal-body">
				<p>This website is currently undergoing a system maintenance and upgrade to improve performance, security, and reliability.</p>

				<p class="section-title">Temporarily Unavailable:</p>
				<ul>
					<li>Online account registration</li>
					<li>New manuscript submissions</li>
					<li>Revision and review submissions via portal</li>
				</ul>

				<p class="section-title">How to Submit During This Period:</p>
				<p>Please contact your respective journal administrator directly via email. Our team will respond with further instructions and the necessary forms to complete your submission.</p>

				<p>We sincerely apologize for any inconvenience and appreciate your understanding and continued support.</p>
				<p><em>&mdash; The UIII Journal Portal Team</em></p>
			</div>
			<div class="modal-footer">
				<button class="modal-confirm-btn" onclick="closeMaintenanceModal()">I Understand</button>
			</div>
		</div>
	</div> *}

	{* JAVASCRIPT *}
	{* <script>
		function openMaintenanceModal() {
			document.getElementById('maintenanceModal').classList.add('active');
		}
		function closeMaintenanceModal() {
			localStorage.setItem('maintenanceModalShown', 'true');
			document.getElementById('maintenanceModal').classList.remove('active');
		}
		document.addEventListener('DOMContentLoaded', function() {
			if (!localStorage.getItem('maintenanceModalShown')) {
				openMaintenanceModal();
			}
		});
	</script> *}
	{* ===== END MAINTENANCE BANNER + MODAL ===== *}
	<div class="container">

		<{$siteNameTag} class="visually-hidden">{$pageTitleTranslated|escape}</{$siteNameTag}>

	<div class="navbar-logo">
		<a href="{$homeUrl}">{$brand}</a>
	</div>

	{* Main navigation *}
	<nav class="navbar navbar-expand-lg navbar-light">
		<a class="navbar-brand" href="{$homeUrl}">{$brand}</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#main-navbar"
		        aria-controls="main-navbar" aria-expanded="false"
		        aria-label="{translate key="plugins.themes.healthSciences.nav.toggle"}">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse justify-content-md-center" id="main-navbar">
			{* primary menu *}
			{capture assign="primaryMenu"}
				{load_menu name="primary" id="primaryNav" ulClass="navbar-nav" liClass="nav-item"}
			{/capture}
			{if !empty(trim($primaryMenu)) || $currentContext}
				{$primaryMenu}
			{/if}
			{* user menu *}
			{load_menu name="user" id="primaryNav-userNav" ulClass="navbar-nav" liClass="nav-item"}
			{include file="frontend/components/languageSwitcher.tpl" id="languageSmallNav"}
		</div>
	</nav>

	{* Repeat the userNav for positioning on large screens *}
	{load_menu name="user" id="userNav" ulClass="navbar-nav" liClass="nav-item"}

	{* Language switcher *}
	{include file="frontend/components/languageSwitcher.tpl" id="languageLargeNav"}

	</div>
</header>

Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:34764 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751934AbcENQoh (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 14 May 2016 12:44:37 -0400
Date: Sat, 14 May 2016 18:44:35 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Lucas Stach <dev@lynxeye.de>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sp5100_tco: properly check for new register layouts
Message-ID: <20160514164435.GA20311@spo001.leaseweb.nl>
References: <1462295758-3299-1-git-send-email-dev@lynxeye.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1462295758-3299-1-git-send-email-dev@lynxeye.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Lucas,

> Commits 190aa4304de6 (Add AMD Mullins platform support) and
> cca118fa2a0a94 (Add AMD Carrizo platform support) enabled the
> driver on a lot more devices, but the following commit missed
> a single location in the code when checking if the SB800 register
> offsets should be used. This leads to the wrong register being
> written which in turn causes ACPI to go haywire.
> 
> Fix this by introducing a helper function to check for the new
> register layout and use this consistently.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=114201
> https://bugzilla.redhat.com/show_bug.cgi?id=1329910
> Fixes: bdecfcdb5461 (sp5100_tco: fix the device check for SB800
> and later chipsets)
> Cc: stable@vger.kernel.org (4.5+)
> Signed-off-by: Lucas Stach <dev@lynxeye.de>
> ---
>  drivers/watchdog/sp5100_tco.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.


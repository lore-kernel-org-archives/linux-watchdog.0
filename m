Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:58714 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161455Ab2GLRnJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 12 Jul 2012 13:43:09 -0400
Date: Thu, 12 Jul 2012 19:43:07 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-watchdog@vger.kernel.org, ben-linux@fluff.org,
	patches@linaro.org
Subject: Re: [PATCH] watchdog: s3c2410_wdt: Use module_platform_driver()
Message-ID: <20120712174307.GH735@spo001.leaseweb.com>
References: <1342093660-19735-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1342093660-19735-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Sachin,

> module_platform_driver() replaces module_init() and module_exit()
> and makes the code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Added to linux-watchdog-next.

Kind regards,
Wim.


Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:52239 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751738AbaAMUlO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 13 Jan 2014 15:41:14 -0500
Date: Mon, 13 Jan 2014 21:41:12 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/1] watchdog: sirf: Remove redundant of_match_ptr helper
Message-ID: <20140113204112.GA23348@spo001.leaseweb.com>
References: <1387614673-2740-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1387614673-2740-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Sachin,

> 'sirfsoc_wdt_of_match' is always compiled in. Hence the
> helper macro is not needed.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Added to linux-watchdog-next.

Kind regards,
Wim.


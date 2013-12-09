Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60040 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932791Ab3LIQ2H (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 9 Dec 2013 11:28:07 -0500
Message-ID: <52A5EF6B.6060700@ti.com>
Date: Mon, 9 Dec 2013 11:27:23 -0500
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
MIME-Version: 1.0
To: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>, <wim@iguana.be>
CC: <linux-arm-kernel@lists.infradead.org>, <mark.rutland@arm.com>,
	<nsekhar@ti.com>, <linux-watchdog@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <Pawel.Moll@arm.com>,
	<swarren@wwwdotorg.org>, <ijc+devicetree@hellion.org.uk>,
	<galak@kernel.crashing.org>, <rob.herring@calxeda.com>,
	<linux-kernel@vger.kernel.org>, <grant.likely@linaro.org>,
	<grygorii.strashko@ti.com>
Subject: Re: [PATCH v5 0/5] Update Davinci watchdog driver
References: <1386185970-14488-1-git-send-email-ivan.khoronzhuk@ti.com>
In-Reply-To: <1386185970-14488-1-git-send-email-ivan.khoronzhuk@ti.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Wim,

On Wednesday 04 December 2013 02:39 PM, Ivan Khoronzhuk wrote:
> These patches are intended to update Davinci watchdog to use WDT core
> and reuse driver for keystone arch, because Keystone uses the similar
> IP like Davinci.
> 

[..]

> v4..v5:
> - watchdog: davinci: change driver to use WDT core
> 	switched off CONFIG_WATCHDOG_NOWAYOUT option
> 
Can you please apply the series to your watchdog tree ?
Do let me know if you want us to prepare a git branch
to pull from.

Regards,
Santosh

Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56337 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbbFYNqd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 25 Jun 2015 09:46:33 -0400
Message-ID: <558C0634.9050802@roeck-us.net>
Date: Thu, 25 Jun 2015 06:46:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: poeschel@lemonage.de, wim@iguana.be, corbet@lwn.net,
	linux-doc@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: omap_wdt: early_enable module parameter
References: <1435227711-29875-1-git-send-email-poeschel@lemonage.de>
In-Reply-To: <1435227711-29875-1-git-send-email-poeschel@lemonage.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/25/2015 03:21 AM, poeschel@lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
>
> Add a early_enable module parameter to the omap_wdt that starts the
> watchdog on module insertion. The default value is 0 which does not
> start the watchdog - which also does not change the behavior if the
> parameter is not given.
>
> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34413 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbbDZP33 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 26 Apr 2015 11:29:29 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1YmOUq-000YWP-Rr
	for linux-watchdog@vger.kernel.org; Sun, 26 Apr 2015 15:29:29 +0000
Message-ID: <553D0450.6050403@roeck-us.net>
Date: Sun, 26 Apr 2015 08:29:20 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: balbi@ti.com,
	=?windows-1252?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
CC: Lokesh Vutla <lokeshvutla@ti.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
	linux-watchdog@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1a/3] watchdog: omap: clearify device tree documentation
References: <20150424190207.GU19431@pengutronix.de> <1429906850-5420-1-git-send-email-u.kleine-koenig@pengutronix.de> <20150425021024.GA14963@saruman.tx.rr.com>
In-Reply-To: <20150425021024.GA14963@saruman.tx.rr.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/24/2015 07:10 PM, Felipe Balbi wrote:
> On Fri, Apr 24, 2015 at 10:20:50PM +0200, Uwe Kleine-König wrote:
>> ti,hwmods doesn't belong into the compatible section but is a property
>> on it's own. Also reformat the section of required properties to match the
>> usual style of dt binding documents.
>>
>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>
> looks great to me, thanks
>
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> Acked-by: Felipe Balbi <balbi@ti.com>
>

Reviewed-by: and Acked-by: are mutually exclusive.

Guenter


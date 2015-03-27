Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42156 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbbC0Fsq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 27 Mar 2015 01:48:46 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YbN8P-000D37-Fj
	for linux-watchdog@vger.kernel.org; Fri, 27 Mar 2015 05:48:45 +0000
Message-ID: <5514EF25.4000400@roeck-us.net>
Date: Thu, 26 Mar 2015 22:48:21 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>,
	Baruch Siach <baruch@tkos.co.il>
CC: Wim Van Sebroeck <wim@iguana.be>, devicetree@vger.kernel.org,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] watchdog: digicolor: driver for Conexant Digicolor
 CX92755 SoC
References: <a4554d0a61c62b85a7d66b6e3d16d07f8a498025.1427356791.git.baruch@tkos.co.il>	<148dd2d6912211bc468c30acf85a463192576039.1427356791.git.baruch@tkos.co.il> <CAM=Q2ctS6_=pzW2H+Yd3nEBgF269vfdh8yV3NbnWFP7b-MWLbA@mail.gmail.com>
In-Reply-To: <CAM=Q2ctS6_=pzW2H+Yd3nEBgF269vfdh8yV3NbnWFP7b-MWLbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/26/2015 10:40 PM, Shubhrajyoti Datta wrote:
>
>     +
>     +static int dc_restart_handler(struct notifier_block *this, unsigned long mode,
>     +                             void *cmd)
>     +{
>     +       struct dc_wdt *wdt = container_of(this, struct dc_wdt, restart_handler);
>     +
>     +       dc_wdt_set(wdt, 1);
>     +       /* wait for reset to assert... */
>     +       mdelay(500);
>
>
> How is the 500 calculated ?
> Also is it possible to sleep here?
>
sleep: No. It would also be pretty pointless, since this is after all the very last step
of rebooting the system.

Guenter


Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33221 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbbAVFbt (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 22 Jan 2015 00:31:49 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YEAMu-000KOI-09
	for linux-watchdog@vger.kernel.org; Thu, 22 Jan 2015 05:31:48 +0000
Message-ID: <54C08B3E.60302@roeck-us.net>
Date: Wed, 21 Jan 2015 21:31:42 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Jisheng Zhang <jszhang@marvell.com>,
	Doug Anderson <dianders@chromium.org>
CC: Wim Van Sebroeck <wim@iguana.be>, Heiko Stuebner <heiko@sntech.de>,
	Lunxue Dai <lunxue.dai@rock-chips.com>,
	Dinh Nguyen <dinguyen@altera.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] watchdog: dw_wdt: pat the watchdog before enabling
 it
References: <1421882243-3631-1-git-send-email-dianders@chromium.org> <20150122132200.4729d38b@xhacker>
In-Reply-To: <20150122132200.4729d38b@xhacker>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/21/2015 09:22 PM, Jisheng Zhang wrote:
> Dear Doug,
>
> On Wed, 21 Jan 2015 15:17:22 -0800
> Doug Anderson <dianders@chromium.org> wrote:
>
>> On some dw_wdt implementations the "top" register may be initted to 0
>> at bootup.  In such a case, each "pat" of the watchdog will reset the
>> timer to 0xffff.  That's pretty short.
>
> + Guenter Roeck
>
> This should have been fixed by dfa07141e7a792("watchdog: dw_wdt: initialise
> TOP_INIT in dw_wdt_set_top()")
>
Ah, yes. Doug, can you check if your patch is still needed ?

Thanks,
Guenter


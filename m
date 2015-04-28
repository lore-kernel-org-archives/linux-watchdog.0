Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57169 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752597AbbD1BkA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Apr 2015 21:40:00 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1YmuVD-001gSA-0F
	for linux-watchdog@vger.kernel.org; Tue, 28 Apr 2015 01:39:59 +0000
Message-ID: <553EE4EC.1000403@roeck-us.net>
Date: Mon, 27 Apr 2015 18:39:56 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Eric Anholt <eric@anholt.net>
CC: linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Stephen Warren <swarren@wwwdotorg.org>,
	Lee Jones <lee@kernel.org>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: BCM2835: Move the restart/power_off handling
 to the WDT driver.
References: <1429902534-2348-1-git-send-email-eric@anholt.net> <1429902534-2348-2-git-send-email-eric@anholt.net> <20150427160432.GD5701@roeck-us.net> <20150427160517.GA11074@roeck-us.net> <877fsx9nd6.fsf@eliezer.anholt.net>
In-Reply-To: <877fsx9nd6.fsf@eliezer.anholt.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/27/2015 04:12 PM, Eric Anholt wrote:
> Guenter Roeck <linux@roeck-us.net> writes:
>
>> On Mon, Apr 27, 2015 at 09:04:32AM -0700, Guenter Roeck wrote:
>>> On Fri, Apr 24, 2015 at 12:08:54PM -0700, Eric Anholt wrote:
>>>> Since the WDT is what's used to drive restart and power off, it makes
>>>> more sense to keep it there, where the regs are already mapped and
>>>> definitions for them provided.  Note that this means you may need to
>>>> add CONFIG_BCM2835_WDT to retain functionality of your kernel.
>>>>
>>>> Signed-off-by: Eric Anholt <eric@anholt.net>
>>>> Cc: linux-watchdog@vger.kernel.org
>>>
>>> The patch will require a rebase to v4.0-rc1.
>>>
>> s/4.0/4.1/
>
> It will?  It seems to work fine, and the diff's the same.  Is there some
> new thing you were expecting in a rebase?
>
All I can say is that it didn't apply for me. Maybe someone else has more luck.

Guenter


Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:47661 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbbFRCId (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 17 Jun 2015 22:08:33 -0400
Message-ID: <5582281F.8060402@wwwdotorg.org>
Date: Wed, 17 Jun 2015 20:08:31 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: =?UTF-8?B?Tm9yYWxmIFRyw7hubmVz?= <noralf@tronnes.org>
CC: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] watchdog: bcm2835: Fix poweroff behaviour
References: <1434549844-11704-1-git-send-email-noralf@tronnes.org>
In-Reply-To: <1434549844-11704-1-git-send-email-noralf@tronnes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/17/2015 08:04 AM, Noralf Trønnes wrote:
> Currently poweroff/halt results in a reboot on the Raspberry Pi.
> The firmware uses the RSTS register to know which partiton to
> boot from. The partiton value is spread into bits
> 0, 2, 4, 6, 8, 10. Partiton 63 is a special partition used by
> the firmware to indicate halt.
> 
> The firmware made this change in 19 Aug 2013 and was matched
> by the downstream commit:
> Changes for new NOOBS multi partition booting from gsh

Tested-by: Stephen Warren <swarren@wwwdotorg.org>
Acked-by: Stephen Warren <swarren@wwwdotorg.org>

I wonder if, sometime down the road, it's worth querying the firmware
version via the firmware driver and dynamically doing the right thing.
Still, the combination of a bleeding edge kernel and an ancient firmware
seems a bit unlikely, so perhaps not worth the bother.

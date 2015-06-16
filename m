Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:56796 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbbFPDJy (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 15 Jun 2015 23:09:54 -0400
Message-ID: <557F9380.1000607@wwwdotorg.org>
Date: Mon, 15 Jun 2015 21:09:52 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: =?UTF-8?B?Tm9yYWxmIFRyw7hubmVz?= <noralf@tronnes.org>
CC: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ARM: dts: bcm2835-rpi: Add "brcm,raspberrypi-pm-wdt"
 to wdt compatible
References: <1434195541-28368-1-git-send-email-noralf@tronnes.org> <1434195541-28368-3-git-send-email-noralf@tronnes.org>
In-Reply-To: <1434195541-28368-3-git-send-email-noralf@tronnes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/13/2015 05:39 AM, Noralf Trønnes wrote:
> The Raspberry Pi uses a new value for halt in the PM_RSTS watchdog
> register. Expand the compatible string to cover this.

FWIW, the series,
Tested-by: Stephen Warren <swarren@wwwdotorg.org>

... but that doesn't imply my ack for the patches.

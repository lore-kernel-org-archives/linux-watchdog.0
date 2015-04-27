Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from shell.v3.sk ([195.168.3.45]:41631 "EHLO shell.v3.sk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932642AbbD0NFD (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Apr 2015 09:05:03 -0400
Message-ID: <1430139503.3948.11.camel@v3.sk>
Subject: Re: [PATCH 2/2] ARM: BCM2835: Move the restart/power_off handling
 to the WDT driver.
From: Lubomir Rintel <lkundrak@v3.sk>
To: Eric Anholt <eric@anholt.net>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org
Date: Mon, 27 Apr 2015 14:58:23 +0200
In-Reply-To: <1429902534-2348-2-git-send-email-eric@anholt.net>
References: <1429902534-2348-1-git-send-email-eric@anholt.net>
	 <1429902534-2348-2-git-send-email-eric@anholt.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, 2015-04-24 at 12:08 -0700, Eric Anholt wrote:
> Since the WDT is what's used to drive restart and power off, it makes
> more sense to keep it there, where the regs are already mapped and
> definitions for them provided.  Note that this means you may need to
> add CONFIG_BCM2835_WDT to retain functionality of your kernel.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Cc: linux-watchdog@vger.kernel.org

Acked-by: Lubomir Rintel <lkundrak@v3.sk>

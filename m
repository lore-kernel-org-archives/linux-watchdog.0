Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:35944 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939254AbdDTWgd (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 20 Apr 2017 18:36:33 -0400
Date: Thu, 20 Apr 2017 15:36:29 -0700
From: Brian Norris <computersforpeace@gmail.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, john@phrozen.org,
        hauke.mehrtens@intel.com
Subject: Re: [PATCH 02/13] mtd: lantiq-flash: drop check of boot select
Message-ID: <20170420223629.GI20555@google.com>
References: <20170417192942.32219-1-hauke@hauke-m.de>
 <20170417192942.32219-3-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170417192942.32219-3-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Apr 17, 2017 at 09:29:31PM +0200, Hauke Mehrtens wrote:
> Do not check which flash type the SoC was booted from before
> using this driver. Assume that the device tree is correct and use this
> driver when it was added to device tree. This also removes a build
> dependency to the SoC code.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Presuming you get the platform details right (i.e., device tree), I'm
happy with this. It's not really this driver's job to check your boot
strappings.

Acked-by: Brian Norris <computersforpeace@gmail.com>

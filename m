Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37650 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751945AbdIAOba (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 1 Sep 2017 10:31:30 -0400
Date: Fri, 1 Sep 2017 09:31:29 -0500
From: Rob Herring <robh@kernel.org>
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Roc He <hepeng@zidoo.tv>,
        =?utf-8?B?6JKL5Li955C0?= <jiang.liqin@geniatech.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: realtek: Add watchdog node for RTD1295
Message-ID: <20170901143129.b3rzi7waqc3sz32j@rob-hp-laptop>
References: <20170828113532.32627-1-afaerber@suse.de>
 <20170828113532.32627-4-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170828113532.32627-4-afaerber@suse.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Aug 28, 2017 at 01:35:31PM +0200, Andreas Färber wrote:
> Add the watchdog node to the RTD1295 Device Tree.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  Depends on the pending clock nodes patch.
>  
>  arch/arm64/boot/dts/realtek/rtd1295.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>


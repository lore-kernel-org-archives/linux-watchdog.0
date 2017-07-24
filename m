Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38760 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754182AbdGXRtb (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 24 Jul 2017 13:49:31 -0400
Date: Mon, 24 Jul 2017 12:49:29 -0500
From: Rob Herring <robh@kernel.org>
To: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Cc: wim@iguana.be, linux@roeck-us.net, mark.rutland@arm.com,
        joel@jms.id.au, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH v5 1/2] drivers/watchdog: Add optional ASPEED device tree
 properties
Message-ID: <20170724174929.wtf5ifjr2h7eixdc@rob-hp-laptop>
References: <20170717192539.7950-1-cbostic@linux.vnet.ibm.com>
 <20170717192539.7950-2-cbostic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170717192539.7950-2-cbostic@linux.vnet.ibm.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jul 17, 2017 at 02:25:38PM -0500, Christopher Bostic wrote:
> Describe device tree optional properties:
> 
>   * aspeed,reset-type = "cpu|soc|system|none"
>      One of three different, mutually exclusive, values
> 
> 	"cpu" : ARM CPU reset on signal
> 	"soc" : 'System on chip' reset
> 	"system" : Full system reset
> 
>      The value can also be set to "none" which indicates that no
>      reset of any kind is to be done via this watchdog.  This assumes
>      another watchdog on the chip is to take care of resets.
> 
>   * aspeed,external-signal - Generate external signal (WDT1 and WDT2 only)
>   * aspeed,alt-boot - Boot from alternate block on signal
> 
> Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
> ---
> v5 - Removed aspeed,interrupt property - no plans at this point to
>      need this functionality in the driver.
> v4 - Add aspeed-reset-type and assign one of four values,
>      cpu, soc, system, none.
> v3 - Invert soc and sys reset to 'no' to preserve backwards
>      compatibility.  SOC and SYS reset will be set by default
>      without any optional parameters set
> v2 - Add 'aspeed,' prefix to all optional properties
>    - Add arm-reset, soc-reset, interrupt, alt-boot properties
> ---
>  .../devicetree/bindings/watchdog/aspeed-wdt.txt    | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>

Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53084 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030546AbeEXQHe (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 24 May 2018 12:07:34 -0400
Date: Thu, 24 May 2018 09:07:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Ray Jui <ray.jui@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] Documentation: DT: Add optional 'timeout-sec'
 property for sp805
Message-ID: <20180524160729.GA27710@roeck-us.net>
References: <1527014840-21236-1-git-send-email-ray.jui@broadcom.com>
 <1527014840-21236-2-git-send-email-ray.jui@broadcom.com>
 <af81ea74-fb80-11e2-7bdc-d3607bdbd46b@arm.com>
 <20180523181058.GC27570@roeck-us.net>
 <91d27df4-29d0-de7f-6805-c3e5f329caf3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91d27df4-29d0-de7f-6805-c3e5f329caf3@arm.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, May 24, 2018 at 02:25:34PM +0100, Robin Murphy wrote:
> On 23/05/18 19:10, Guenter Roeck wrote:
> >On Wed, May 23, 2018 at 11:57:25AM +0100, Robin Murphy wrote:
> >>On 22/05/18 19:47, Ray Jui wrote:
> >>>Update the SP805 binding document to add optional 'timeout-sec'
> >>>devicetree property
> >>>
> >>>Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> >>>Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> >>>---
> >>>  Documentation/devicetree/bindings/watchdog/sp805-wdt.txt | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>>
> >>>diff --git a/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt b/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
> >>>index edc4f0e..f898a86 100644
> >>>--- a/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
> >>>+++ b/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
> >>>@@ -19,6 +19,8 @@ Required properties:
> >>>  Optional properties:
> >>>  - interrupts : Should specify WDT interrupt number.
> >>>+- timeout-sec : Should specify default WDT timeout in seconds. If unset, the
> >>>+                default timeout is 30 seconds
> >>
> >>According to the SP805 TRM, the default interval is dependent on the rate of
> >>WDOGCLK, but would typically be a lot longer than that :/
> >>
> >Depends on the definition of "default". In the context of watchdog drivers,
> >it is (or should be) a driver default, not a chip default.
> 
> DT describes hardware, not driver behaviour.
> 

In this case it describes expected system behavior. Most definitely
it does not describe some hardware default.

Please note that I do not engage in discussions I consider bike-shedding.
This is one of those. Dropping out.

Guenter

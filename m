Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33483 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeLGXsg (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 7 Dec 2018 18:48:36 -0500
Date: Fri, 7 Dec 2018 17:48:33 -0600
From: Rob Herring <robh@kernel.org>
To: Eric Anholt <eric@anholt.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v3 1/5] dt-bindings: soc: Add a new binding for the
 BCM2835 PM node.
Message-ID: <20181207234833.GA27917@bogus>
References: <20181130202743.20585-1-eric@anholt.net>
 <20181130202743.20585-2-eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130202743.20585-2-eric@anholt.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, 30 Nov 2018 12:27:39 -0800, Eric Anholt wrote:
> This binding supersedes the bcm2835-pm-wdt binding which only covered
> enough to provide a watchdog, but the HW block is actually mostly
> about power domains.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  .../bindings/soc/bcm/brcm,bcm2835-pm.txt      | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

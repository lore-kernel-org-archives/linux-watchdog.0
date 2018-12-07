Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36695 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeLGXtf (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 7 Dec 2018 18:49:35 -0500
Date: Fri, 7 Dec 2018 17:49:33 -0600
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
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v3 3/5] soc: bcm: bcm2835-pm: Add support for power
 domains under a new binding.
Message-ID: <20181207234933.GA28189@bogus>
References: <20181130202743.20585-1-eric@anholt.net>
 <20181130202743.20585-4-eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130202743.20585-4-eric@anholt.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Nov 30, 2018 at 12:27:41PM -0800, Eric Anholt wrote:
> This provides a free software alternative to raspberrypi-power.c's
> firmware calls to manage power domains.  It also exposes a reset line,
> where previously the vc4 driver had to try to force power off the
> domain in order to trigger a reset.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/mfd/bcm2835-pm.c             |  36 +-
>  drivers/soc/bcm/Kconfig              |  11 +
>  drivers/soc/bcm/Makefile             |   1 +
>  drivers/soc/bcm/bcm2835-power.c      | 661 +++++++++++++++++++++++++++
>  include/dt-bindings/soc/bcm2835-pm.h |  28 ++

Acked-by: Rob Herring <robh@kernel.org>

>  include/linux/mfd/bcm2835-pm.h       |   1 +
>  6 files changed, 734 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/soc/bcm/bcm2835-power.c
>  create mode 100644 include/dt-bindings/soc/bcm2835-pm.h

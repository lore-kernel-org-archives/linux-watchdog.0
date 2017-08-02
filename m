Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53381 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750742AbdHBEqG (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 2 Aug 2017 00:46:06 -0400
From: Andrew Jeffery <andrew@aj.id.au>
To: linux-watchdog@vger.kernel.org
Cc: Andrew Jeffery <andrew@aj.id.au>, wim@iguana.be,
        linux@roeck-us.net, robh+dt@kernel.org, mark.rutland@arm.com,
        joel@jms.id.au, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org
Subject: [PATCH 0/2] watchdog: aspeed: External reset signal properties
Date: Wed,  2 Aug 2017 14:15:27 +0930
Message-Id: <20170802044529.30032-1-andrew@aj.id.au>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello,

This two-patch series builds on top of Chris Bostic's changes introducing the
aspeed,external-signal devicetree property (currently v5):

    https://lkml.org/lkml/2017/7/17/777

Additional characteristics such as pulse width, push-pull vs open-drain driving
and active high or low polarity can be configured. This short series defines
optional properties to do so, and adds support to the driver.

Cheers,

Andrew

Andrew Jeffery (2):
  dt-bindings: watchdog: aspeed: External reset signal properties
  watchdog: aspeed: Support configuration of external signal properties

 .../devicetree/bindings/watchdog/aspeed-wdt.txt    |  10 +-
 drivers/watchdog/aspeed_wdt.c                      | 105 ++++++++++++++++++++-
 2 files changed, 111 insertions(+), 4 deletions(-)

-- 
2.11.0


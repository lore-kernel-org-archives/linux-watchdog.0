Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:22874 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755236AbdGKGl0 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 11 Jul 2017 02:41:26 -0400
Subject: Re: [PATCH v7 14/16] phy: Add an USB PHY driver for the Lantiq SoCs
 using the RCU module
To: Rob Herring <robh@kernel.org>, Hauke Mehrtens <hauke@hauke-m.de>
References: <20170702224051.15109-1-hauke@hauke-m.de>
 <20170702224051.15109-15-hauke@hauke-m.de>
 <20170707142312.5pwily3gbntvesbm@rob-hp-laptop>
CC: <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-mtd@lists.infradead.org>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <martin.blumenstingl@googlemail.com>,
        <john@phrozen.org>, <linux-spi@vger.kernel.org>,
        <hauke.mehrtens@intel.com>, <andy.shevchenko@gmail.com>,
        <p.zabel@pengutronix.de>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <30adb3f5-50b5-35e3-685f-9fe0fa8c31f8@ti.com>
Date: Tue, 11 Jul 2017 12:08:01 +0530
MIME-Version: 1.0
In-Reply-To: <20170707142312.5pwily3gbntvesbm@rob-hp-laptop>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On Friday 07 July 2017 07:53 PM, Rob Herring wrote:
> On Mon, Jul 03, 2017 at 12:40:49AM +0200, Hauke Mehrtens wrote:
>> This driver starts the DWC2 core(s) built into the XWAY SoCs and provides
>> the PHY interfaces for each core. The phy instances can be passed to the
>> dwc2 driver, which already supports the generic phy interface.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> Cc: Kishon Vijay Abraham I <kishon@ti.com>

I see you have added my name in cc but for some reason I don't have the patch
in my mailbox. Can you resend it please?

>> ---
>>  .../bindings/phy/phy-lantiq-rcu-usb2.txt           |  42 ++++
>>  arch/mips/lantiq/xway/sysctrl.c                    |  24 +-
>>  drivers/phy/Kconfig                                |   8 +
>>  drivers/phy/Makefile                               |   1 +
>>  drivers/phy/phy-lantiq-rcu-usb2.c                  | 275 +++++++++++++++++++++

Please create a new directory withing phy for adding a phy driver.

Thanks
Kishon

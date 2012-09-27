Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:37867 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163Ab2I0PAW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 27 Sep 2012 11:00:22 -0400
Received: by obbuo13 with SMTP id uo13so1845341obb.19
        for <linux-watchdog@vger.kernel.org>; Thu, 27 Sep 2012 08:00:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120927055021.GO17667@game.jcrosoft.org>
References: <1348568704-28304-1-git-send-email-fabio.porcedda@gmail.com>
 <1348568704-28304-3-git-send-email-fabio.porcedda@gmail.com> <20120927055021.GO17667@game.jcrosoft.org>
From: Fabio Porcedda <fabio.porcedda@gmail.com>
Date: Thu, 27 Sep 2012 17:00:01 +0200
Message-ID: <CAHkwnC-76qUZaKHA7O5rdMDCAbDB52b9UL9hKWWiTBFQHpUS0g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ARM: at91: add at91sam9_wdt driver to at91sam926x, at91sam9g45
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Andrew Victor <linux@maxim.org.za>,
	devicetree-discuss@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Sep 27, 2012 at 7:50 AM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 12:25 Tue 25 Sep     , Fabio Porcedda wrote:
>> Enable the driver for the evk-pro3 board.
>>
>> Tested on an at91sam9260 board (evk-pro3).
>>
>> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
>> ---
>>  arch/arm/boot/dts/at91sam9260.dtsi | 6 ++++++
>>  arch/arm/boot/dts/at91sam9263.dtsi | 6 ++++++
>>  arch/arm/boot/dts/at91sam9g45.dtsi | 6 ++++++
>>  arch/arm/boot/dts/evk-pro3.dts     | 4 ++++
> split board and soc

Ok, i will send an updated patch.

> Best Regards,
> J.

Best regards
-- 
Fabio Porcedda

Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:36585 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932180AbcJUIjp (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 21 Oct 2016 04:39:45 -0400
Received: by mail-qk0-f179.google.com with SMTP id o68so138343690qkf.3
        for <linux-watchdog@vger.kernel.org>; Fri, 21 Oct 2016 01:39:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1475853574-22339-4-git-send-email-pantelis.antoniou@konsulko.com>
References: <1475853574-22339-1-git-send-email-pantelis.antoniou@konsulko.com> <1475853574-22339-4-git-send-email-pantelis.antoniou@konsulko.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 21 Oct 2016 10:39:43 +0200
Message-ID: <CACRpkdY681yE+zo51BSrBjvhFPQV3KkhM9QH600uiqLfP8G=fw@mail.gmail.com>
Subject: Re: [PATCH 3/4] gpio: ptxpmb-ext-cpld: Add driver for Juniper's
 PTXPMB extended CPLD
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Lee Jones <lee.jones@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Georgi Vlaev <gvlaev@juniper.net>,
        Guenter Roeck <linux@roeck-us.net>,
        JawaharBalaji Thirumalaisamy <jawaharb@juniper.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        linux-watchdog@vger.kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Oct 7, 2016 at 5:19 PM, Pantelis Antoniou
<pantelis.antoniou@konsulko.com> wrote:

> From: Guenter Roeck <groeck@juniper.net>
>
> This IP block is present in the PTXPMB extended CPLD present on
> Junipers PTX series of routers and provides SIB connector status pins
> as GPIO pins for use with other drivers.
>
> Signed-off-by: Guenter Roeck <groeck@juniper.net>
> Signed-off-by: JawaharBalaji Thirumalaisamy <jawaharb@juniper.net>
> [Ported from Juniper kernel]
> Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>

This driver has pretty much the same issues as the two others
I reviewed yesterday. Please address the same comments
and repost and I will look at it again!

Yours,
Linus Walleij

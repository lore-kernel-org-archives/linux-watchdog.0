Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:56734 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751981AbdBAT4O (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 1 Feb 2017 14:56:14 -0500
Subject: Re: [PATCH 4/6] bus: add driver for the Technologic Systems NBUS
To: Linus Walleij <linus.walleij@linaro.org>
References: <20161214231237.17496-1-sebastien.bourdelin@savoirfairelinux.com>
 <20161214231237.17496-5-sebastien.bourdelin@savoirfairelinux.com>
 <CACRpkdYHHrYY-fAPnNmV94ejFJ36rhSF0SqSVHkTNq+YCRNNZw@mail.gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@savoirfairelinux.com>, mark@embeddedarm.com,
        kris@embeddedarm.com, Simon Horman <horms+renesas@verge.net.au>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        damien.riegel@savoirfairelinux.com,
        Lucile Quirion <lucile.quirion@savoirfairelinux.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
From: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Message-ID: <7bc0871f-ac0a-e8a0-0c84-a0e61b3991a8@savoirfairelinux.com>
Date: Wed, 1 Feb 2017 14:56:11 -0500
MIME-Version: 1.0
In-Reply-To: <CACRpkdYHHrYY-fAPnNmV94ejFJ36rhSF0SqSVHkTNq+YCRNNZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Linus,

Thanks for your feedback.
I have a question regarding your recommendation, see below.

On 12/30/2016 02:58 AM, Linus Walleij wrote:

>> +
>> +static DEFINE_MUTEX(ts_nbus_lock);
>> +static bool ts_nbus_ready;
> 
> Why not move this to the struct ts_nbus state container?
> 
> It seems to be per-bus not per-system.
> 
>> +#define TS_NBUS_READ_MODE  0
>> +#define TS_NBUS_WRITE_MODE 1
>> +#define TS_NBUS_DIRECTION_IN  0
>> +#define TS_NBUS_DIRECTION_OUT 1
>> +#define TS_NBUS_WRITE_ADR 0
>> +#define TS_NBUS_WRITE_VAL 1
>> +
>> +struct ts_nbus {
>> +       struct pwm_device *pwm;
>> +       int num_data;
>> +       int *data;
>> +       int csn;
>> +       int txrx;
>> +       int strobe;
>> +       int ale;
>> +       int rdy;
>> +};
>> +
>> +static struct ts_nbus *ts_nbus;
> 
> Nopes. No singletons please.
> 
> Use the state container pattern:
> Documentation/driver-model/design-patterns.txt
> 

I understand the idea but have problem to find a good way to implement it.

Other drivers using the NBUS which are child nodes in the device tree
will use the ts_nbus_write() and ts_nbus_read() functions, it means these
drivers should have a pointer to the allocated ts_nbus and pass it to
the write() and read() functions as an argument if i'm not using a
singleton here.
But i'm lacking knowledge on how to properly share this pointer when
initializing the NBUS driver with the child nodes.

Perhaps my design is not appropriate for what i'm doing, if someone can
point me on a similar problematic it will be really helpful.

Best Regards,
Sebastien.

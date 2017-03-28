Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:33597 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754643AbdC1Igq (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Mar 2017 04:36:46 -0400
MIME-Version: 1.0
In-Reply-To: <20170328082141.u2rgnhei5yhhzxdn@dell>
References: <539b8756120ab3558c906f7457e65f94dbe37425.1490608293.git.stwiss.opensource@diasemi.com>
 <201703272258.hWlipe1g%fengguang.wu@intel.com> <20170328082141.u2rgnhei5yhhzxdn@dell>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Mar 2017 10:36:43 +0200
Message-ID: <CAMuHMdX8WH959h50zGQCV7o4E249xBKDn_cVtRbFwYVsVebu9w@mail.gmail.com>
Subject: Re: [PATCH V6 4/7] mfd: da9061: MFD core support
To: Lee Jones <lee.jones@linaro.org>
Cc: kbuild test robot <lkp@intel.com>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        DEVICETREE <devicetree@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        LINUX-INPUT <linux-input@vger.kernel.org>,
        LINUX-PM <linux-pm@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Lee,

On Tue, Mar 28, 2017 at 10:21 AM, Lee Jones <lee.jones@linaro.org> wrote:
>> [auto build test WARNING on ljones-mfd/for-mfd-next]
>> [also build test WARNING on v4.11-rc4 next-20170327]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Steve-Twiss/Documentation-devicetree-watchdog-da9062-61-watchdog-timer-binding/20170327-215359
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
>> config: x86_64-randconfig-x009-201713 (attached as .config)
>> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
>> reproduce:
>>         # save the attached .config to linux build tree
>>         make ARCH=x86_64
>>
>> All warnings (new ones prefixed by >>):
>>
>>    drivers//mfd/da9062-core.c: In function 'da9062_i2c_probe':
>> >> drivers//mfd/da9062-core.c:845:21: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>>       chip->chip_type = (int)match->data;
>>                        ^
>
> Please use longs or enums.

Enums would still give a warning on 64-bit.
The simple fix is change the cast from (int) to (uintptr_t).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

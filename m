Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:49322 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbdJDMea (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 4 Oct 2017 08:34:30 -0400
MIME-Version: 1.0
In-Reply-To: <6b854d35-6430-c790-3608-15cefac03a52@linux.intel.com>
References: <cover.1504588701.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <3e7a05561840a7dd4fa945e4969edb834d9870b6.1504588701.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAHp75Vd4wNg9tpRUHpkk8-Y75xXtPe4F7_27dPQHZT9uN9DJ5g@mail.gmail.com> <6b854d35-6430-c790-3608-15cefac03a52@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 4 Oct 2017 15:34:29 +0300
Message-ID: <CAHp75VfC-d5p7_G65uh=w0tfRok1_TZAh3Re9088re=gsz1rOw@mail.gmail.com>
Subject: Re: [RFC v3 2/7] platform/x86: intel_pmc_ipc: Use MFD framework to
 create dependent devices
To: Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        "x86@kernel.org" <x86@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Ingo Molnar <mingo@redhat.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy@infradead.org>,
        Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Sathyanarayanan Kuppuswamy Natarajan <sathyaosid@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Oct 4, 2017 at 4:00 AM, sathyanarayanan kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> On 10/01/2017 07:44 AM, Andy Shevchenko wrote:
>> On Tue, Sep 5, 2017 at 8:37 AM,

>>> +       punit_cell.id = -1;
>
> I will remove this line in next version.
>>>
>>> +       return devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
>>> +                       &punit_cell, 1, NULL, 0, NULL);
>>
>> IIRC you don't need to file cell ID in case of DEVID_AUTO.
>
> I am planning to use DEVID_NONE here to match the current behavior. Unless
> you have some concerns?

Preventing behaviour is a good thing to do.
In either way cell.id can be leaved 0.

-- 
With Best Regards,
Andy Shevchenko

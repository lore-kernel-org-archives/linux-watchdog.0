Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47670 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967349AbdADBjH (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 3 Jan 2017 20:39:07 -0500
Subject: Re: [PATCH 3/4] watchdog: iTCO_wdt: Use pdev for platform device and
 pci_dev for pci device
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1483454364-28650-1-git-send-email-linux@roeck-us.net>
 <1483454364-28650-3-git-send-email-linux@roeck-us.net>
 <CAHp75Vc0KR_w8k4bdacyU-i=CrKiS7jUqKTSMWEwTrcN-ZrcJQ@mail.gmail.com>
 <20170103234047.GB13952@roeck-us.net>
 <CAHp75VcYArTMypmCZxM=kj_m-iWqKuOXd7V=fnWNv5Q+jmN0xw@mail.gmail.com>
 <CAHp75VdVDG7aDgW8TOK-TQoAS5p8LC+U6jnhbZv-KwEoyzsDNQ@mail.gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <2b44637f-d9aa-c0a5-1532-421b474e35e4@roeck-us.net>
Date: Tue, 3 Jan 2017 17:38:58 -0800
MIME-Version: 1.0
In-Reply-To: <CAHp75VdVDG7aDgW8TOK-TQoAS5p8LC+U6jnhbZv-KwEoyzsDNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/03/2017 03:50 PM, Andy Shevchenko wrote:
> On Wed, Jan 4, 2017 at 1:48 AM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Wed, Jan 4, 2017 at 1:40 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>>> On Wed, Jan 04, 2017 at 12:39:59AM +0200, Andy Shevchenko wrote:
>>>> On Tue, Jan 3, 2017 at 4:39 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>>>>> Use pdev for struct platform_device, pcidev for struct pci_dev, and dev
>>>>> for struct device variables to improve consistency.
>>>>>
>>>>> Remove 'struct platform_device *dev;' from struct iTCO_wdt_private since
>>>>> it was unused.
>>>>
>>>> Would pci_dev work?
>>>>
>>> Sure, or maybe just 'pci'. Any preference ?
>>
>> Just slightly prefer pci_dev over others (pcidev, pci), but do not
>> insist. Up to you.
>
> Or even
>
> struct device *dev;
> ...
> struct pci_dev *pci_dev = to_pci_dev(dev);
>

'dev' would have to be a pointer to the parent device. If I consider using
dev_{info,err}, I'll need 'dev' in struct iTCO_wdt_private. I think I'll
stick with pci_dev.

Thanks,
Guenter


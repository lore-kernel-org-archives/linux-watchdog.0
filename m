Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32941 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751315AbdJDBA2 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 3 Oct 2017 21:00:28 -0400
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [RFC v3 2/7] platform/x86: intel_pmc_ipc: Use MFD framework to
 create dependent devices
To: Andy Shevchenko <andy.shevchenko@gmail.com>
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
References: <cover.1504588701.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <3e7a05561840a7dd4fa945e4969edb834d9870b6.1504588701.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAHp75Vd4wNg9tpRUHpkk8-Y75xXtPe4F7_27dPQHZT9uN9DJ5g@mail.gmail.com>
From: sathyanarayanan kuppuswamy
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <6b854d35-6430-c790-3608-15cefac03a52@linux.intel.com>
Date: Tue, 3 Oct 2017 18:00:15 -0700
MIME-Version: 1.0
In-Reply-To: <CAHp75Vd4wNg9tpRUHpkk8-Y75xXtPe4F7_27dPQHZT9uN9DJ5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Andy,


On 10/01/2017 07:44 AM, Andy Shevchenko wrote:
> On Tue, Sep 5, 2017 at 8:37 AM,
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> Currently, we have lot of repetitive code in dependent device resource
>> allocation and device creation handling code. This logic can be improved if
>> we use MFD framework for dependent device creation. This patch adds this
>> support.
>>
>> +       punit_cell.id = -1;
I will remove this line in next version.
>> +       return devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
>> +                       &punit_cell, 1, NULL, 0, NULL);
> IIRC you don't need to file cell ID in case of DEVID_AUTO.
I am planning to use DEVID_NONE here to match the current behavior. 
Unless you have some concerns?
>

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer


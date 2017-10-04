Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45558 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751115AbdJDBHE (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 3 Oct 2017 21:07:04 -0400
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [RFC v3 0/7] PMC/PUNIT IPC driver cleanup
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
 <CAHp75VcRGqb86cfggF9zFtfzkZkx7CSH9-nYQ2rk_G8Rgn2t7w@mail.gmail.com>
From: sathyanarayanan kuppuswamy
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <61866414-0801-1962-9c92-410a4b82b006@linux.intel.com>
Date: Tue, 3 Oct 2017 18:06:51 -0700
MIME-Version: 1.0
In-Reply-To: <CAHp75VcRGqb86cfggF9zFtfzkZkx7CSH9-nYQ2rk_G8Rgn2t7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Andy,

Thanks for the review. I really appreciate you taking the time to review 
such big chunk of code changes.


On 10/01/2017 07:46 AM, Andy Shevchenko wrote:
> On Tue, Sep 5, 2017 at 8:37 AM,
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> Hi All,
>>
>> Currently intel_pmc_ipc.c, intel_punit_ipc.c, intel_scu_ipc.c drivers implements the same IPC features.
>> This code duplication could be avoided if we implement the IPC driver as a generic library and let custom
>> device drivers use API provided by generic driver. This patchset mainly addresses this issue.
>>
>> Along with above code duplication issue, This patchset also addresses following issues in intel_pmc_ipc and
>> intel_punit_ipc drivers.
>>
>> 1. Intel_pmc_ipc.c driver does not use any resource managed (devm_*) calls.
>> 2. In Intel_pmc_ipc.c driver, dependent devices like PUNIT, Telemetry and iTCO are created manually and uses lot of redundant buffer code.
>> 3. Global variable is used to store the IPC device structure and it is used across all functions in intel_pmc_ipc.c and intel_punit_ipc.c.
>>
>> More info on Intel IPC device library:
>> -------------------------------------
>>
>> A generic Intel IPC class driver has been implemented and all common IPC helper functions has been moved to this driver. It exposes APIs to create IPC device channel, send raw IPC command and simple IPC commands. It also creates device attribute to send IPC command from user space.
>>
>> API for creating a new IPC channel device is,
>>
>> struct intel_ipc_dev *devm_intel_ipc_dev_create(struct device *dev, const char *devname, struct intel_ipc_dev_cfg *cfg, struct intel_ipc_dev_ops *ops)
>>
>> The IPC channel drivers (PUNIT/PMC/SCU) when creating a new device can configure their device params like register mapping, irq, irq-mode, channel type,etc  using intel_ipc_dev_cfg and intel_ipc_dev_ops arguments. After a new IPC channel device is created, IPC users can use the generic APIs to make IPC calls.
>>
>> For example, after using this new model, IPC call to PMC device will look like,
>>
>> pmc_ipc_dev = intel_ipc_dev_get(INTEL_PMC_IPC_DEV);
>> ipc_dev_raw_cmd(pmc_ipc_dev, cmd, PMC_PARAM_LEN, (u32 *)ipc_in, 1, NULL, 0, 0, 0);
>>
>> I am still testing the driver in different products. But posted it to get some early comments. I also welcome any PMC/PUNIT driver users to check these patches in their product.
> I have applied first patch from the series with some small changes.
> Please rebase the rest on top of my review branch (review-andy).
Will do. I will soon send v4 version.
> Before sending new version, address comments that others and me did.
Yes.
>

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer


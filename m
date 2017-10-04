Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56636 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751225AbdJDBHb (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 3 Oct 2017 21:07:31 -0400
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [RFC v3 4/7] platform: x86: Add generic Intel IPC driver
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
 <7d1a79925df8d2e35cfbd6974706d0d1ef0fc0de.1504588701.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAHp75VecDGzs=esey6hSDWMxvYPeeiy5T-9x6MNFaHspLq0ctA@mail.gmail.com>
From: sathyanarayanan kuppuswamy
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <96f8c550-da66-c11f-4db4-34fe520188aa@linux.intel.com>
Date: Tue, 3 Oct 2017 18:07:18 -0700
MIME-Version: 1.0
In-Reply-To: <CAHp75VecDGzs=esey6hSDWMxvYPeeiy5T-9x6MNFaHspLq0ctA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,


On 10/01/2017 07:59 AM, Andy Shevchenko wrote:
> On Tue, Sep 5, 2017 at 8:37 AM,
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> Currently intel_scu_ipc.c, intel_pmc_ipc.c and intel_punit_ipc.c
>> redundantly implements the same IPC features and has lot of code
>> duplication between them. This driver addresses this issue by grouping
>> the common IPC functionalities under the same driver.
>> +static const char *ipc_dev_err_string(struct intel_ipc_dev *ipc_dev,
>> +       int error)
>> +{
>> +       switch (error) {
>> +       case IPC_DEV_ERR_NONE:
>> +               return "No error";
>> +       case IPC_DEV_ERR_CMD_NOT_SUPPORTED:
>> +               return "Command not-supported/Invalid";
>> +       case IPC_DEV_ERR_CMD_NOT_SERVICED:
>> +               return "Command not-serviced/Invalid param";
>> +       case IPC_DEV_ERR_UNABLE_TO_SERVICE:
>> +               return "Unable-to-service/Cmd-timeout";
>> +       case IPC_DEV_ERR_CMD_INVALID:
>> +               return "Command-invalid/Cmd-locked";
>> +       case IPC_DEV_ERR_CMD_FAILED:
>> +               return "Command-failed/Invalid-VR-id";
>> +       case IPC_DEV_ERR_EMSECURITY:
>> +               return "Invalid Battery/VR-Error";
>> +       case IPC_DEV_ERR_UNSIGNEDKERNEL:
>> +               return "Unsigned kernel";
>> +       default:
>> +               return "Unknown Command";
>> +       };
>> +}
> Since it's continuous list you can define an array of messages like
>
> const char * const *errors = {
>   [..._ERR_...] = "",
>   ...
>
> };
>
> Also you can use enum in the header and define _ERR_MAX there.
> Thus, code would be transformed to
>
> if (error < _ERR_MAX)
>   return errors[error];
>
> return "Unknown Command";
Thanks will fix it in next version.
>

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer


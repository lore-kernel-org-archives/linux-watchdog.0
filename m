Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:50658 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753288AbdDDUSs (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 4 Apr 2017 16:18:48 -0400
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v4 2/5] platform/x86: intel_pmc_ipc: Add pmc gcr
 read/write/update api's
References: <e537ff68732d86418982349624fd6de741bccc9b.1491002056.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20170331133728.GA23725@rajaneesh-OptiPlex-9010>
 <1ca7187132bd2b98ca87d0829a3c76022f041924.1491002056.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAHp75Vc0Mjk81TLDVwr9jkeeHqCvJ729aQLqg09zov7--AjKyw@mail.gmail.com>
 <CAENHMvPLE5KZMZ+NoU5fmNzDEoONz=SeAaSC=q8GfhFEHFOJ6g@mail.gmail.com>
 <CAHp75VdZmQyo8ZwLgbybzUvEzYj+upxR74Ah0ViVBB=Ykk+Dsw@mail.gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sathyanarayanan Kuppuswamy Natarajan <sathyaosid@gmail.com>
Cc: Andy Shevchenko <andy@infradead.org>,
        Zha Qipeng <qipeng.zha@intel.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        David Box <david.e.box@linux.intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org
From: sathyanarayanan kuppuswamy
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <c158bcb3-c6c2-3f81-c38b-6a63e6c1af5e@linux.intel.com>
Date: Tue, 4 Apr 2017 13:14:37 -0700
MIME-Version: 1.0
In-Reply-To: <CAHp75VdZmQyo8ZwLgbybzUvEzYj+upxR74Ah0ViVBB=Ykk+Dsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Andy,


On 04/04/2017 06:23 AM, Andy Shevchenko wrote:
> On Mon, Apr 3, 2017 at 4:51 AM, Sathyanarayanan Kuppuswamy Natarajan
> <sathyaosid@gmail.com> wrote:
>
>>>> +static inline int is_gcr_valid(u32 offset)
>>> Pointer to ipcdev should be a parameter to this function.
>> But ipcdev is a static variable, visible across this file. So there is
>> no point in passing it as parameter.
> That's one of refactoring needed for this library. You need to pass a
> pointer to all internal functions and where it's possible to avoid
> reference to a global variable.
Yes, I have included this into the list of issues that needs to fixed 
during the refactoring effort.
>

-- 
Sathyanarayanan Kuppuswamy
Android kernel developer


Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:49076 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751975AbdJ0QZC (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 27 Oct 2017 12:25:02 -0400
MIME-Version: 1.0
In-Reply-To: <31869190769e357ae56dd345dce5862bab4eff4a.1508368279.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1508368279.git.sathyanarayanan.kuppuswamy@linux.intel.com> <31869190769e357ae56dd345dce5862bab4eff4a.1508368279.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 27 Oct 2017 19:25:01 +0300
Message-ID: <CAHp75Vc8kww3YSNEtR4dYp4Y2o2XiQ5YpkrW_nSkjSn0mpWh-A@mail.gmail.com>
Subject: Re: [RFC v6 4/9] platform/x86: intel_pmc_ipc: Use MFD framework to
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

On Thu, Oct 19, 2017 at 3:23 AM,
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> Currently, we have lot of repetitive code in dependent device resource
> allocation and device creation handling code. This logic can be improved if
> we use MFD framework for dependent device creation. This patch adds this
> support.

I have applied this patch with some modifications to my review-andy branch.
Please, take it from there (and probably patch 3) and resend new
version of the series based on our testing branch.

P.S. This patch still needs more work, I will comment on new version.

-- 
With Best Regards,
Andy Shevchenko

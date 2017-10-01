Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:52966 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdJAOoh (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 1 Oct 2017 10:44:37 -0400
MIME-Version: 1.0
In-Reply-To: <3e7a05561840a7dd4fa945e4969edb834d9870b6.1504588701.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1504588701.git.sathyanarayanan.kuppuswamy@linux.intel.com> <3e7a05561840a7dd4fa945e4969edb834d9870b6.1504588701.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 1 Oct 2017 17:44:35 +0300
Message-ID: <CAHp75Vd4wNg9tpRUHpkk8-Y75xXtPe4F7_27dPQHZT9uN9DJ5g@mail.gmail.com>
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

On Tue, Sep 5, 2017 at 8:37 AM,
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> Currently, we have lot of repetitive code in dependent device resource
> allocation and device creation handling code. This logic can be improved if
> we use MFD framework for dependent device creation. This patch adds this
> support.
>

> +       punit_cell.id = -1;

> +       return devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
> +                       &punit_cell, 1, NULL, 0, NULL);

IIRC you don't need to file cell ID in case of DEVID_AUTO.

-- 
With Best Regards,
Andy Shevchenko

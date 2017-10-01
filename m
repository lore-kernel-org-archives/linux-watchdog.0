Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33016 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbdJAOqQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 1 Oct 2017 10:46:16 -0400
MIME-Version: 1.0
In-Reply-To: <cover.1504588701.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1504588701.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 1 Oct 2017 17:46:14 +0300
Message-ID: <CAHp75VcRGqb86cfggF9zFtfzkZkx7CSH9-nYQ2rk_G8Rgn2t7w@mail.gmail.com>
Subject: Re: [RFC v3 0/7] PMC/PUNIT IPC driver cleanup
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Sep 5, 2017 at 8:37 AM,
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.=
com>
>
> Hi All,
>
> Currently intel_pmc_ipc.c, intel_punit_ipc.c, intel_scu_ipc.c drivers imp=
lements the same IPC features.
> This code duplication could be avoided if we implement the IPC driver as =
a generic library and let custom
> device drivers use API provided by generic driver. This patchset mainly a=
ddresses this issue.
>
> Along with above code duplication issue, This patchset also addresses fol=
lowing issues in intel_pmc_ipc and
> intel_punit_ipc drivers.
>
> 1. Intel_pmc_ipc.c driver does not use any resource managed (devm_*) call=
s.
> 2. In Intel_pmc_ipc.c driver, dependent devices like PUNIT, Telemetry and=
 iTCO are created manually and uses lot of redundant buffer code.
> 3. Global variable is used to store the IPC device structure and it is us=
ed across all functions in intel_pmc_ipc.c and intel_punit_ipc.c.
>
> More info on Intel IPC device library:
> -------------------------------------
>
> A generic Intel IPC class driver has been implemented and all common IPC =
helper functions has been moved to this driver. It exposes APIs to create I=
PC device channel, send raw IPC command and simple IPC commands. It also cr=
eates device attribute to send IPC command from user space.
>
> API for creating a new IPC channel device is,
>
> struct intel_ipc_dev *devm_intel_ipc_dev_create(struct device *dev, const=
 char *devname, struct intel_ipc_dev_cfg *cfg, struct intel_ipc_dev_ops *op=
s)
>
> The IPC channel drivers (PUNIT/PMC/SCU) when creating a new device can co=
nfigure their device params like register mapping, irq, irq-mode, channel t=
ype,etc  using intel_ipc_dev_cfg and intel_ipc_dev_ops arguments. After a n=
ew IPC channel device is created, IPC users can use the generic APIs to mak=
e IPC calls.
>
> For example, after using this new model, IPC call to PMC device will look=
 like,
>
> pmc_ipc_dev =3D intel_ipc_dev_get(INTEL_PMC_IPC_DEV);
> ipc_dev_raw_cmd(pmc_ipc_dev, cmd, PMC_PARAM_LEN, (u32 *)ipc_in, 1, NULL, =
0, 0, 0);
>
> I am still testing the driver in different products. But posted it to get=
 some early comments. I also welcome any PMC/PUNIT driver users to check th=
ese patches in their product.

I have applied first patch from the series with some small changes.
Please rebase the rest on top of my review branch (review-andy).
Before sending new version, address comments that others and me did.

--=20
With Best Regards,
Andy Shevchenko

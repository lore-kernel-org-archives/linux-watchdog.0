Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3A6352023
	for <linux-watchdog@vger.kernel.org>; Tue, 19 May 2026 23:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779233135; cv=pass; b=dZE4aGh7PObtU+maQa8639mRR0ohLrV08Bqn6QplohGFo0E2O0BJYhiVaJjU06iBZD8KK9IPYgp7qJgZrGpBFqF68FvH0G89UnvFLdlnFNldu3X8+DnFFVa43meMrcpJfn/nBpoQcvxlQ1Sw7QPHChjuBrhX0q1+8nYRZetvTpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779233135; c=relaxed/simple;
	bh=lDU6byiR3vFwEOvj5j3DZtZ6d068YCzCtecScl6pG+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lfa4fALXf2vdl6CqvAqvRm++S8ybm/KxH0PA0XIoglbGUI+OUit1ndm9VbA9bldSvk4TMddHaAD6dzsGgNz/A813f3q4fV6PiadFnrfnVZ6dbDHukcGUAqt8DkQVDdLiK3dsaOjOPNX6oKe3idHOmMlMiTfYNkbGgDJ27AEkJOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RB6xThkN; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RB6xThkN"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67cac5ece75so8762814a12.2
        for <linux-watchdog@vger.kernel.org>; Tue, 19 May 2026 16:25:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779233132; cv=none;
        d=google.com; s=arc-20240605;
        b=O3EO7o+IfcqTSy1EUvJRwwZqTkW+yrvkyL4tf2PAFxdRe5dQdW2GkMaDlskFjti5VU
         2mneIHaHuijjy1PQ1MccbcfmDwOq3ru03xGLO/YIpLCkuLfbNECE+Ml3vPwE6wd/13Em
         Pz5WDT9rylqcYh0Nf+QQNMUxg/NVAP0tKdc436ZRrbhjODHiRwxTYurlMMfzM1m36WKM
         VWeZvEscCinTrjdOrl/LSEKIj87IK++0N+BHf1vof/so3lKYIi8GoDS+fyzfxGEqpOsA
         v4+DvzFQXAyml3+7dGTacvu4tGhn+BtQimTINFbx8LGtkrsfv8TlzLt3vyqyGtw1CkHb
         67uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yx9UePKvOUzAnD9brYdO5mRsneVNzD11jhKEq8jtaR4=;
        fh=FJE0Z1GZdAMudjUr2H6FLc0DWrHWA8QakvIVOuQqiKg=;
        b=hrivpKTa2VQPh96KD41qhOKaFGLswT6FeXqZ3Ej7M4yLskD9HCchXQPRF/kldtBCZP
         71nYWrwkZOf9qb1l8fejMLF6OecyzIWt65OsXk+JX0WPGTdI5r7ZYa3zNrTCZHD9E5BV
         tyzF05VlaGXs9fm6OV15MmH+UUP19cgMUct/fMzj7YGDfD0/XFTnTNlooS7NrRDz2AAk
         VqOf7/dOLAZfZEUH0O6W1GCasCkxNSi5gMDiNg3m8dD8tF1yxXthGiB8lYWl6TdMpROm
         iKWns95pE7S+Oan2axpZrxDSplt6Alq0NxUrkJF7w4Sr7RqU9MVrW4gzvZd+nFzCKgbP
         x6tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779233132; x=1779837932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yx9UePKvOUzAnD9brYdO5mRsneVNzD11jhKEq8jtaR4=;
        b=RB6xThkN4SlWCMyocQQlb+vZrsRIWKi5/pUhd2YZnl3PRKKztzUbPnWMiPmLTKCQjo
         3bHGcLuE5YxeoDpamAFcLxlKrrWNf82p6bVkKkbZeOlQQX9JGXgjzqAs/2s9LQcKiZWl
         igIjdpOVXpOe27+UcSJH6U0M1AU0///2eExm+4hwZomXaofHQxTWjJ9H5WFa39a4ND+z
         74U0cn9f7aF5a31wsCi0PFcIdf5arHLqoC8i57h0Ygb6R3WLY96YqvyYI3wuHtVDdS7j
         Z5zfj3YCA7G1wCUPfvf6DDM7AvIU57PmIijnm1qXo6QMpGO3dQaJd8MV7xliyg9ts3QD
         7b8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779233132; x=1779837932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yx9UePKvOUzAnD9brYdO5mRsneVNzD11jhKEq8jtaR4=;
        b=iw/Ol4cACDlqij22eJNt6b6WPYGwfxF+/y5kpQBQAC0+zKUJ9gtM3X0uyP67dzH1tn
         6sY0wyqWljX4HmCcnzbJwuCF4LTxX6sdqNjxGJUEbVYfB+E4esmiZ2Go+z4zK7nfzKu4
         tu1YztwuTOcvMqaNfUSkLUiqhXvuew7R08a73hkUaSvN5YPehgP4C9CTRlaSoYv85iDI
         aJrXJ4fpsFpxigPirrzIrB8azE1u3t1Vg/3Tp+sJPSE8dkuWhbLXPBS6yEwAcCBHVT3h
         GIlBV/6QLCUn3HfBWBE9GqnEdHnoQ3tCHg8pIMiL0zcvZrLFyDaQSu/YnRDhU6yd3FjN
         NMtw==
X-Gm-Message-State: AOJu0Yw8KyxNloCwQQ09LLznX23naWoqb4FFTlM8ZPlYE+odHEVmuRd7
	ab2XnEc8Xib0LqAnr1nptKewK5mwfUv6SJHIRMLhZrtfXQ5LKgPw7kur3b1xwV6ANiBoSC0g7zl
	Hxd3Oou+z3m0T45phy9GrERLctqOMO1QkDvB+
X-Gm-Gg: Acq92OFp6baRX2z14gPXycZQaHnAVQT0eF5cpga0tuQqxdMTvzs54PX0n7i2QFHEz89
	7MmQOCRWGp1iLGYnKsW0s6pmQaEzQu0/B5zeXpyCHjn5nJw5s6SLt2GxDCpc5THkq2LikBAOTTt
	pT8wdKZ13t+M0TNuxf22RAMn802K9Jv/1ukTewrEVBn6cMRVI3X0su7Yup4dzbcDnrTMjrcRZRF
	ovkD2nd7xk+xar9UDIVkrKk2OIbcPKlya15j+6eCUnLpH2N4lHJzoxYOtBcmwObBgXRbstk9mmJ
	FiNLPH2rEuP9VUI2o4lUsMVtLQLd1f8o8dsWZb800kPHegOCiu3gBC/V88C8AMAeqycx2lrXHQC
	i9w9U9Kbi3Ai60hwvFBvssqlpu4/Xak8KmpGRdOKSdQFHsy742mRMQSGDCvofH8Bw0Co+
X-Received: by 2002:a17:906:dc8c:b0:bd6:5288:58cf with SMTP id
 a640c23a62f3a-bd652885de2mr801074666b.42.1779233131867; Tue, 19 May 2026
 16:25:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519003326.625858-1-rosenp@gmail.com> <e20e7cba-a926-4796-b310-4aff3830ad69@roeck-us.net>
In-Reply-To: <e20e7cba-a926-4796-b310-4aff3830ad69@roeck-us.net>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 19 May 2026 16:25:20 -0700
X-Gm-Features: AVHnY4Ly62jBNrUoBRXtkBTjgMHVIcsEoROFV-vBix_AfsLq3FnoFle6bfqyAfo
Message-ID: <CAKxU2N-sNEOKBAoAX2K-ZhpvnKFzANt8SrYVoskp_B62_b9=+w@mail.gmail.com>
Subject: Re: [PATCH] watchdog: ath79: convert to watchdog_device
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 4:10=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On Mon, May 18, 2026 at 05:33:26PM -0700, Rosen Penev wrote:
> > Converts from the legacy miscdevice/file_operations interface to the
>
> s/Converts/Convert/
>
> > watchdog_device framework, simplifying the driver and properly handling
> > EPROBE_DEFER.
> >
> > Use wdd->timeout in all callbacks instead of a global, fix get_timeleft=
()
> > to return seconds instead of raw clock ticks, store max_timeout in the
> > watchdog_device struct, wire up nowayout via watchdog_set_nowayout(), p=
ass
> > the module parameter to watchdog_init_timeout(), add .owner to
> > watchdog_ops, and remove the leftover file-ops state (wdt_flags and the
> > busy/expect-close bits).
> >
> > Tested on an Archer C7v2. sysupgrade watchdog handoff works fine.
> >
> Sorry for having to ask, but is this real or an AI hallucination ?
Tested line was added by me. Tested before submitting.
>
> > Assisted-by: Claude:Sonnet-4.6
Yeah this one is garbage compared to the prior one I used.
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
> $ scripts/checkpatch.pl --strict index.html.1
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> #163: FILE: drivers/watchdog/ath79_wdt.c:62:
> +static inline void ath79_wdt_wr(struct ath79_wdt *wdt, unsigned reg, u32=
 val)
>
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> #170: FILE: drivers/watchdog/ath79_wdt.c:67:
> +static inline u32 ath79_wdt_rr(struct ath79_wdt *wdt, unsigned reg)
>
> Please run checkpatch --strict on your patches.
Will do. I have to do a lot more manual editing with this one (which I
did prior to submission).
>
> The patch does not apply to the tip of the watchdog-next branch.
>
> $ git am -s -3 index.html
> Applying: watchdog: ath79: convert to watchdog_device
> error: sha1 information is lacking or useless (drivers/watchdog/ath79_wdt=
.c).
> error: could not build fake ancestor
>
> Please base it on a known reference so it can be applied.
Interesting. I use linux-next as a baseline for all my patches.
>
> Additional patches inline.
>
> Thanks,
> Guenter
>
> > ---
> >  drivers/watchdog/ath79_wdt.c | 244 +++++++++++------------------------
> >  1 file changed, 73 insertions(+), 171 deletions(-)
> >
> > diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.=
c
> > index 409a40b14901..d83957712c02 100644
> > --- a/drivers/watchdog/ath79_wdt.c
> > +++ b/drivers/watchdog/ath79_wdt.c
> > @@ -15,13 +15,10 @@
> >
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> No longer needed.
>
> >
> > -#include <linux/bitops.h>
> >  #include <linux/delay.h>
> >  #include <linux/errno.h>
> > -#include <linux/fs.h>
> >  #include <linux/io.h>
> >  #include <linux/kernel.h>
> > -#include <linux/miscdevice.h>
> >  #include <linux/module.h>
> >  #include <linux/moduleparam.h>
> >  #include <linux/platform_device.h>
> > @@ -31,7 +28,6 @@
> >  #include <linux/err.h>
> >  #include <linux/of.h>
> >  #include <linux/of_platform.h>
> > -#include <linux/uaccess.h>
> >
> >  #define DRIVER_NAME  "ath79-wdt"
> >
> > @@ -57,37 +53,32 @@ module_param(timeout, int, 0);
> >  MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds "
> >                         "(default=3D" __MODULE_STRING(WDT_TIMEOUT) "s)"=
);
> >
> > -static unsigned long wdt_flags;
> > -
> > -#define WDT_FLAGS_BUSY               0
> > -#define WDT_FLAGS_EXPECT_CLOSE       1
> > -
> > -static struct clk *wdt_clk;
> > -static unsigned long wdt_freq;
> > -static int boot_status;
> > -static int max_timeout;
> > -static void __iomem *wdt_base;
> > +struct ath79_wdt {
> > +     void __iomem *base;
> > +     unsigned long freq;
> > +     struct watchdog_device wdd;
> > +};
> >
> > -static inline void ath79_wdt_wr(unsigned reg, u32 val)
> > +static inline void ath79_wdt_wr(struct ath79_wdt *wdt, unsigned reg, u=
32 val)
> >  {
> > -     iowrite32(val, wdt_base + reg);
> > +     iowrite32(val, wdt->base + reg);
> >  }
> >
> > -static inline u32 ath79_wdt_rr(unsigned reg)
> > +static inline u32 ath79_wdt_rr(struct ath79_wdt *wdt, unsigned reg)
> >  {
> > -     return ioread32(wdt_base + reg);
> > +     return ioread32(wdt->base + reg);
> >  }
> >
> > -static inline void ath79_wdt_keepalive(void)
> > +static inline void ath79_wdt_keepalive(struct ath79_wdt *wdt)
> >  {
> > -     ath79_wdt_wr(WDOG_REG_TIMER, wdt_freq * timeout);
> > +     ath79_wdt_wr(wdt, WDOG_REG_TIMER, wdt->freq * wdt->wdd.timeout);
> >       /* flush write */
> > -     ath79_wdt_rr(WDOG_REG_TIMER);
> > +     ath79_wdt_rr(wdt, WDOG_REG_TIMER);
> >  }
> >
> > -static inline void ath79_wdt_enable(void)
> > +static inline void ath79_wdt_enable(struct ath79_wdt *wdt)
> >  {
> > -     ath79_wdt_keepalive();
> > +     ath79_wdt_keepalive(wdt);
> >
> >       /*
> >        * Updating the TIMER register requires a few microseconds
> > @@ -97,202 +88,115 @@ static inline void ath79_wdt_enable(void)
> >        */
> >       udelay(2);
> >
> > -     ath79_wdt_wr(WDOG_REG_CTRL, WDOG_CTRL_ACTION_FCR);
> > +     ath79_wdt_wr(wdt, WDOG_REG_CTRL, WDOG_CTRL_ACTION_FCR);
> >       /* flush write */
> > -     ath79_wdt_rr(WDOG_REG_CTRL);
> > +     ath79_wdt_rr(wdt, WDOG_REG_CTRL);
> >  }
> >
> > -static inline void ath79_wdt_disable(void)
> > +static inline void ath79_wdt_disable(struct ath79_wdt *wdt)
> >  {
> > -     ath79_wdt_wr(WDOG_REG_CTRL, WDOG_CTRL_ACTION_NONE);
> > +     ath79_wdt_wr(wdt, WDOG_REG_CTRL, WDOG_CTRL_ACTION_NONE);
> >       /* flush write */
> > -     ath79_wdt_rr(WDOG_REG_CTRL);
> > +     ath79_wdt_rr(wdt, WDOG_REG_CTRL);
> >  }
> >
> > -static int ath79_wdt_set_timeout(int val)
> > +static int ath79_wdt_ping(struct watchdog_device *wdd)
> >  {
> > -     if (val < 1 || val > max_timeout)
> > -             return -EINVAL;
> > +     struct ath79_wdt *wdt =3D watchdog_get_drvdata(wdd);
> >
> > -     timeout =3D val;
> > -     ath79_wdt_keepalive();
> > +     ath79_wdt_keepalive(wdt);
> >
> >       return 0;
> >  }
> >
> > -static int ath79_wdt_open(struct inode *inode, struct file *file)
> > +static int ath79_wdt_set_timeout(struct watchdog_device *wdd, unsigned=
 int val)
> >  {
> > -     if (test_and_set_bit(WDT_FLAGS_BUSY, &wdt_flags))
> > -             return -EBUSY;
> > +     struct ath79_wdt *wdt =3D watchdog_get_drvdata(wdd);
> >
> > -     clear_bit(WDT_FLAGS_EXPECT_CLOSE, &wdt_flags);
> > -     ath79_wdt_enable();
> > +     wdd->timeout =3D val;
> > +     ath79_wdt_keepalive(wdt);
> >
> > -     return stream_open(inode, file);
> > +     return 0;
> >  }
> >
> > -static int ath79_wdt_release(struct inode *inode, struct file *file)
> > +static int ath79_wdt_start(struct watchdog_device *wdd)
> >  {
> > -     if (test_bit(WDT_FLAGS_EXPECT_CLOSE, &wdt_flags))
> > -             ath79_wdt_disable();
> > -     else {
> > -             pr_crit("device closed unexpectedly, watchdog timer will =
not stop!\n");
> > -             ath79_wdt_keepalive();
> > -     }
> > +     struct ath79_wdt *wdt =3D watchdog_get_drvdata(wdd);
> >
> > -     clear_bit(WDT_FLAGS_BUSY, &wdt_flags);
> > -     clear_bit(WDT_FLAGS_EXPECT_CLOSE, &wdt_flags);
> > +     ath79_wdt_enable(wdt);
> >
> >       return 0;
> >  }
> >
> > -static ssize_t ath79_wdt_write(struct file *file, const char *data,
> > -                             size_t len, loff_t *ppos)
> > +static unsigned int ath79_wdt_get_timeleft(struct watchdog_device *wdd=
)
> >  {
> > -     if (len) {
> > -             if (!nowayout) {
> > -                     size_t i;
> > -
> > -                     clear_bit(WDT_FLAGS_EXPECT_CLOSE, &wdt_flags);
> > +     struct ath79_wdt *wdt =3D watchdog_get_drvdata(wdd);
> >
> > -                     for (i =3D 0; i !=3D len; i++) {
> > -                             char c;
> > -
> > -                             if (get_user(c, data + i))
> > -                                     return -EFAULT;
> > +     return ath79_wdt_rr(wdt, WDOG_REG_TIMER) / wdt->freq;
> > +}
> >
> > -                             if (c =3D=3D 'V')
> > -                                     set_bit(WDT_FLAGS_EXPECT_CLOSE,
> > -                                             &wdt_flags);
> > -                     }
> > -             }
> > +static int ath79_wdt_stop(struct watchdog_device *wdd)
> > +{
> > +     struct ath79_wdt *wdt =3D watchdog_get_drvdata(wdd);
> >
> > -             ath79_wdt_keepalive();
> > -     }
> > +     ath79_wdt_disable(wdt);
> >
> > -     return len;
> > +     return 0;
> >  }
> >
> >  static const struct watchdog_info ath79_wdt_info =3D {
> > -     .options                =3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPIN=
G |
> > -                               WDIOF_MAGICCLOSE | WDIOF_CARDRESET,
> > -     .firmware_version       =3D 0,
> > -     .identity               =3D "ATH79 watchdog",
> > +     .options =3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_CARDR=
ESET,
> > +     .firmware_version =3D 0,
>
> Unnecessary; can be dropped.
>
> > +     .identity =3D "ATH79 watchdog",
> >  };
> >
> > -static long ath79_wdt_ioctl(struct file *file, unsigned int cmd,
> > -                         unsigned long arg)
> > -{
> > -     void __user *argp =3D (void __user *)arg;
> > -     int __user *p =3D argp;
> > -     int err;
> > -     int t;
> > -
> > -     switch (cmd) {
> > -     case WDIOC_GETSUPPORT:
> > -             err =3D copy_to_user(argp, &ath79_wdt_info,
> > -                                sizeof(ath79_wdt_info)) ? -EFAULT : 0;
> > -             break;
> > -
> > -     case WDIOC_GETSTATUS:
> > -             err =3D put_user(0, p);
> > -             break;
> > -
> > -     case WDIOC_GETBOOTSTATUS:
> > -             err =3D put_user(boot_status, p);
> > -             break;
> > -
> > -     case WDIOC_KEEPALIVE:
> > -             ath79_wdt_keepalive();
> > -             err =3D 0;
> > -             break;
> > -
> > -     case WDIOC_SETTIMEOUT:
> > -             err =3D get_user(t, p);
> > -             if (err)
> > -                     break;
> > -
> > -             err =3D ath79_wdt_set_timeout(t);
> > -             if (err)
> > -                     break;
> > -             fallthrough;
> > -
> > -     case WDIOC_GETTIMEOUT:
> > -             err =3D put_user(timeout, p);
> > -             break;
> > -
> > -     default:
> > -             err =3D -ENOTTY;
> > -             break;
> > -     }
> > -
> > -     return err;
> > -}
> > -
> > -static const struct file_operations ath79_wdt_fops =3D {
> > -     .owner          =3D THIS_MODULE,
> > -     .write          =3D ath79_wdt_write,
> > -     .unlocked_ioctl =3D ath79_wdt_ioctl,
> > -     .compat_ioctl   =3D compat_ptr_ioctl,
> > -     .open           =3D ath79_wdt_open,
> > -     .release        =3D ath79_wdt_release,
> > -};
> > -
> > -static struct miscdevice ath79_wdt_miscdev =3D {
> > -     .minor =3D WATCHDOG_MINOR,
> > -     .name =3D "watchdog",
> > -     .fops =3D &ath79_wdt_fops,
> > +static const struct watchdog_ops ath79_wdt_ops =3D {
> > +     .owner =3D THIS_MODULE,
> > +     .start =3D ath79_wdt_start,
> > +     .stop =3D ath79_wdt_stop,
> > +     .ping =3D ath79_wdt_ping,
> > +     .set_timeout =3D ath79_wdt_set_timeout,
> > +     .get_timeleft =3D ath79_wdt_get_timeleft,
> >  };
> >
> >  static int ath79_wdt_probe(struct platform_device *pdev)
> >  {
> > +     struct ath79_wdt *wdt;
> > +     struct clk *wdt_clk;
> >       u32 ctrl;
> > -     int err;
> >
> > -     if (wdt_base)
> > -             return -EBUSY;
> > +     wdt =3D devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> > +     if (!wdt)
> > +             return -ENOMEM;
> >
> > -     wdt_base =3D devm_platform_ioremap_resource(pdev, 0);
> > -     if (IS_ERR(wdt_base))
> > -             return PTR_ERR(wdt_base);
> > +     wdt->base =3D devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(wdt->base))
> > +             return PTR_ERR(wdt->base);
> >
> >       wdt_clk =3D devm_clk_get_enabled(&pdev->dev, "wdt");
> >       if (IS_ERR(wdt_clk))
> >               return PTR_ERR(wdt_clk);
> >
> > -     wdt_freq =3D clk_get_rate(wdt_clk);
> > -     if (!wdt_freq)
> > +     wdt->freq =3D clk_get_rate(wdt_clk);
> > +     if (!wdt->freq)
> >               return -EINVAL;
> >
> > -     max_timeout =3D (0xfffffffful / wdt_freq);
> > -     if (timeout < 1 || timeout > max_timeout) {
> > -             timeout =3D max_timeout;
> > -             dev_info(&pdev->dev,
> > -                     "timeout value must be 0 < timeout < %d, using %d=
\n",
> > -                     max_timeout, timeout);
> > -     }
> > -
> > -     ctrl =3D ath79_wdt_rr(WDOG_REG_CTRL);
> > -     boot_status =3D (ctrl & WDOG_CTRL_LAST_RESET) ? WDIOF_CARDRESET :=
 0;
> > +     wdt->wdd.max_timeout =3D U32_MAX / wdt->freq;
> >
> > -     err =3D misc_register(&ath79_wdt_miscdev);
> > -     if (err) {
> > -             dev_err(&pdev->dev,
> > -                     "unable to register misc device, err=3D%d\n", err=
);
> > -             return err;
> > -     }
> > +     ctrl =3D ath79_wdt_rr(wdt, WDOG_REG_CTRL);
> > +     wdt->wdd.bootstatus =3D (ctrl & WDOG_CTRL_LAST_RESET) ? WDIOF_CAR=
DRESET : 0;
> >
> > -     return 0;
> > -}
> > +     wdt->wdd.info =3D &ath79_wdt_info;
> > +     wdt->wdd.ops =3D &ath79_wdt_ops;
> > +     wdt->wdd.min_timeout =3D 1;
> > +     wdt->wdd.timeout =3D WDT_TIMEOUT;
>
> Also:
>         wdt->wdd.parent =3D &pdev->dev;
>
> > +     watchdog_init_timeout(&wdt->wdd, timeout, &pdev->dev);
> > +     watchdog_set_nowayout(&wdt->wdd, nowayout);
> > +     watchdog_stop_on_reboot(&wdt->wdd);
> >
> > -static void ath79_wdt_remove(struct platform_device *pdev)
> > -{
> > -     misc_deregister(&ath79_wdt_miscdev);
> > -}
> > +     watchdog_set_drvdata(&wdt->wdd, wdt);
> >
> > -static void ath79_wdt_shutdown(struct platform_device *pdev)
> > -{
> > -     ath79_wdt_disable();
> > +     return devm_watchdog_register_device(&pdev->dev, &wdt->wdd);
> >  }
> >
> >  static const struct of_device_id ath79_wdt_match[] =3D {
> > @@ -303,8 +207,6 @@ MODULE_DEVICE_TABLE(of, ath79_wdt_match);
> >
> >  static struct platform_driver ath79_wdt_driver =3D {
> >       .probe          =3D ath79_wdt_probe,
> > -     .remove         =3D ath79_wdt_remove,
> > -     .shutdown       =3D ath79_wdt_shutdown,
> >       .driver         =3D {
> >               .name   =3D DRIVER_NAME,
> >               .of_match_table =3D ath79_wdt_match,
> > @@ -314,7 +216,7 @@ static struct platform_driver ath79_wdt_driver =3D =
{
> >  module_platform_driver(ath79_wdt_driver);
> >
> >  MODULE_DESCRIPTION("Atheros AR71XX/AR724X/AR913X hardware watchdog dri=
ver");
> > -MODULE_AUTHOR("Gabor Juhos <juhosg@openwrt.org");
> > -MODULE_AUTHOR("Imre Kaloz <kaloz@openwrt.org");
> > +MODULE_AUTHOR("Gabor Juhos <juhosg@openwrt.org>");
> > +MODULE_AUTHOR("Imre Kaloz <kaloz@openwrt.org>");
> >  MODULE_LICENSE("GPL v2");
> >  MODULE_ALIAS("platform:" DRIVER_NAME);

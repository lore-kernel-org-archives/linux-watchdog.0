Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C249B3E6394
	for <linux-watchdog@vger.kernel.org>; Mon,  8 Jun 2026 20:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949528; cv=pass; b=FriwtKlAJflLJXVRQV0bLtWT4EIOkkQyhnPLHSbqqK9KRHFHQCmZTanblRSWqqybv8C1e2rAiWsgmvpCOxav8GimqpbgXmNV+mzgFey2dZRFTEJBv/wqyyL46v7JTer7gVUCtFuzg1EaznQqpEGOsJfQ36p36k27QQEZM3ZHLXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949528; c=relaxed/simple;
	bh=XpWX9cWXke00UbnzVbKTNfQkbY13yCLNrJPtZCI5UMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bjeS+JCbHFk0iNDktLhFUPFUPASHGAKwU1VWVYzvhdwqJ5c9bwoq2/w7IDQDgGUqb9jNjkjzVowWJpWXSL1AzUnOpexPmxKxAjqBlMDy7p61HXa+PW4VH5AAyV0wWnL3l8lZdglzUFLM9IMzpvjSaZ2OKKklC4hKqIw6nKP6AYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4k35uCT; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4k35uCT"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-68e5f7c1131so8945874a12.2
        for <linux-watchdog@vger.kernel.org>; Mon, 08 Jun 2026 13:12:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780949525; cv=none;
        d=google.com; s=arc-20240605;
        b=S1uSQrf2kjo8r94y+ieIsewq/6TX2zyhBDfksmF75Vv6fQZ809lsx+82/6LcF4G1Z8
         VYv92qiarC3Pl+ipwWqu/T3y7vsAEGhdKHLknUv/vmotliVn92MCY+NpOpmSADJTpzd1
         nJMKLpOdS4bW/Y8FdZRaZFFM22GNCDblZpCoUooYfsAz1wBZm0VWPZFGO4nLb3L73Yk8
         uVMD60S2EHTsUrJRdaXjVmUHQMBX8f3XGDDEuPbzm3pKJ2JwtOR9ZPj1TxJK2sMCU1mF
         VoZUwSHbnynRSaDiPtZD8vD/BHNbV/ub57ez0jznZGegHgDebsTdopv9JyxNKJV3jLPh
         avpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ie7erbFYSlxKVKBCuZe2qFzsyOhWMnLPIgWKaTSeC+Q=;
        fh=i+FQu64Nlc2lwB7Edmn5BnGA0RSKOphddPaCeAB8j3Q=;
        b=B3ffjcoqS+6XdaO4mwGaxBqIW25UEEqNZNhkqlkTbf5x+XiPsFrOSe1h4Itnlx8eTP
         fb3g9boMsAmb7B9RLjd64XOg+YcFRN+GeDDwH8EjLhUehvympY8CTBCuOObP081wg0mt
         SrLCnh/tpiuJaCovYa3EOgNEWtEv87Epr0ofTeUZntG1BF+DZe0pC+PMgvSWaHSZ0lwy
         ZZk3Gg/nIeJybVxUeMSRIw4NUoJYmy3FlkwSscTsnUnOj75m/64bdRfRteJVQ4AJc1et
         0lstHVjTOFJpvWXERlisDFmnUq0Uep3YPWrFsVdOoccCLrQA8GOSyc37unC6ZI/oF0b/
         IoNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780949525; x=1781554325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ie7erbFYSlxKVKBCuZe2qFzsyOhWMnLPIgWKaTSeC+Q=;
        b=P4k35uCTzbTGHMayfOINVulbwDwbbv9awguqjQYa75x25hmMT20dK5+XHLrurDAKU3
         iAJJLqYGkHN/5s0YgU2QfKKnQ6/etMS2YDlMI5CGYPYiQDLnWmS61hM0eBytPET02h/y
         NDIBrAE6Vz2cG0R/00/F1jHXsgD0VnUerFGLHOh4VL+2/Xy1CmY1B23FHrPBGJZq15Ga
         JlZESsSd4YF0efWLtXjiLXSuplWZMyM+GfOjRPZMXcsF6wt6ms/wck8gUdSrb9zUxmnm
         Ia/P7tMj6s7IEBAVBpQVj2hYOWfpbMV1nta3Dwde8RNsIASBDs9LTwLkDtjQ5Vq4CNrW
         ivAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780949525; x=1781554325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ie7erbFYSlxKVKBCuZe2qFzsyOhWMnLPIgWKaTSeC+Q=;
        b=UOQKKBMf0JO6un0x0K/yIzGAA7fmlgrevYB7j6d2y8ZtYmItGQ8/sW0rJ+jyX4W6pz
         hpnsA1aTzosRbkOnfCjKMeRgRY1SwKOBnTmGewHKp1hQwEfSGA0ouBf+8iClOo963hu6
         ZWZ76PfbmafR9guvmRSLhhNL1ZwGzz28zJtgUMB8+m4ObAIhAnLrB1cJZQterQ38h4Dd
         VgVOIFI80x4L4sW29iWFG2PnGLD9sSrCe8OEcvhEFgPowVO5s9tfOc/XkbkIsEEacOh3
         xYR7tWo0Z7HO1vOviTO3Vp1hB4pidfKPdvInImEKAl0xsIPkiCKWMx9m4pe2Xzf518qU
         qAvg==
X-Forwarded-Encrypted: i=1; AFNElJ+4h+KvvUrKKyQ7XLLyeoLs7wB4PSWUlt68tpDhaD+i70MtHNmwoF5OXuYUJvkC85Ip7ZpB5aX+p+jvgWleFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjvseOTQAlAywa7B9M0VZOa6ZlYccqkNylLy9+oLTD5BZBfWUP
	4uu9lbVEDpHkbsB/Oe0PGhZhB0bdp0vsg7bvu3qIUoiO8Qy+RfkKtjsyxr5GvAaInTWQLJAJdnP
	TJR5jh0we447J2ntJnuUrVm7SwiF44lpJIiPK
X-Gm-Gg: Acq92OF4BJXB995OhbIzzoeI9A7KTRqsMN7MIbdhfkCceHMwQNfXj7yAq0PdEuopdKA
	sC4etyHUr2Vw/HRZNATHDEJzX59oZwZNR9loWgwzGF9wUmMf7EKOKuHLk+m5i2v8sn6KRHuNTa4
	A05U3Tr4CkJFN1CZnwjtU/U2CbbN66a63hL+VpXLJ4WuK2WppevIGnb4dlnuGNHIdpREgJshvFM
	lklA57LseDLjiTj/50CuoTtToM5Fwl9pbdS2usR8cpgvSUpIvJ7lOndutkClBlmoD0Kcwk6Sjoq
	Nu3wj1WOyg9jdcSZDirYnxEF24klR3EsiGdu3qXVfqTsJaV3hIe25UqFMpV+qm5/tsn7iSf6J+e
	ihv0EhA4Jxl9fWLP9nXmeeQOJLsDoWhAvUMV/vM+SJxSFupKXSstxsDzKQNICiAxkE8G9
X-Received: by 2002:a05:6402:5251:b0:686:9c15:3121 with SMTP id
 4fb4d7f45d1cf-68fa504626bmr8950050a12.12.1780949524804; Mon, 08 Jun 2026
 13:12:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603005409.226774-1-rosenp@gmail.com> <20260603010104.56C0C1F00893@smtp.kernel.org>
 <19f5c865-0ec6-4079-bb77-cf6f203723fa@roeck-us.net>
In-Reply-To: <19f5c865-0ec6-4079-bb77-cf6f203723fa@roeck-us.net>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 8 Jun 2026 13:11:52 -0700
X-Gm-Features: AVVi8Cco_r-TKhhvTrePrN80x-Q28yG193uETB7XGTu_bg9HZx4eXDdMssZYVGw
Message-ID: <CAKxU2N8SwOzGqjoVrOGQm3fwrhp8M_Q7JGwPFQjOv8y2ubJeTw@mail.gmail.com>
Subject: Re: [PATCH] watchdog: sama5d4_wdt: use platform_get_irq()
To: Guenter Roeck <linux@roeck-us.net>
Cc: sashiko-reviews@lists.linux.dev, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 12:26=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 6/2/26 18:01, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 3 potential is=
sue(s) to consider:
> >
> > New issues:
> > - [High] Assigning the signed result of `platform_get_irq()` to an unsi=
gned `u32` variable causes the `irq < 0` error check to always evaluate to =
false, breaking the driver's fallback mechanism.
> > - [Medium] Using `platform_get_irq()` instead of `platform_get_irq_opti=
onal()` for an optional IRQ causes spurious error messages to be logged.
> >
> > Pre-existing issues:
> > - [High] The driver registers a shared interrupt handler (`IRQF_SHARED`=
) before setting the platform driver data, creating a race condition that c=
an lead to a NULL pointer dereference.
> > --
> >
> > commit 7ff7f2de154616b7a42f6e5710f322b20ff6152e
> > Author: Rosen Penev <rosenp@gmail.com>
> >
> > watchdog: sama5d4_wdt: use platform_get_irq()
> >
> > irq_of_parse_and_map() requires irq_dispose_mapping() on failure. Don't
> > bother with it as platform_get_irq doesn't need it.
> >
> >> diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4=
_wdt.c
> >> index 13e72918338a2..d9b212557ce36 100644
> >> --- a/drivers/watchdog/sama5d4_wdt.c
> >> +++ b/drivers/watchdog/sama5d4_wdt.c
> >> @@ -286,8 +286,8 @@ static int sama5d4_wdt_probe(struct platform_devic=
e *pdev)
> >>              return ret;
> >>
> >>      if (wdt->need_irq) {
> >> -            irq =3D irq_of_parse_and_map(dev->of_node, 0);
> >> -            if (!irq) {
> >> +            irq =3D platform_get_irq(pdev, 0);
> >> +            if (irq < 0) {
> >
> > [Severity: High]
> > Since irq is declared as an unsigned u32 earlier in sama5d4_wdt_probe()=
, won't
> > this irq < 0 check always evaluate to false?
> >
> > platform_get_irq() returns a negative error code (like -ENXIO) on failu=
re,
> > which will be implicitly cast to a large positive integer. Instead of
> > gracefully falling back by setting wdt->need_irq =3D false, won't the d=
river
> > proceed to call devm_request_irq() with an invalid IRQ number and fail =
the
> > probe?
> >
>
> Please fix the problems reported by Sashiko. That applies to all your pat=
ches.
Done for the reported ones. Sent as a series.
>
> Since it appears that you are fixing bugs based on issues reported by AI =
agents,
Difficult to do given how late in the merge window this is. The other
issue is every time I fix bugs reported by sashiko, it complains about
new pre-existing ones. Cat and Mouse game at best.
> I would kindly ask you to fix _all_ problems in the drivers you are modif=
ying,
> not just a selected subset. In this specific case, the problem below is m=
uch more
> serious than the problem you are trying to fix. On top of that, the fix i=
ntroduces
> two new problems while trying to fix one. That is not really helpful.
Agreed.
>
> Thanks,
> Guenter
>
> > [Severity: Medium]
> > Will this log spurious error messages when the IRQ is genuinely absent?
> >
> > The driver treats the IRQ as optional and handles its absence gracefull=
y.
> > However, platform_get_irq() internally calls dev_err_probe(), printing =
a
> > core-level error message to the kernel log when an IRQ is not found. Sh=
ould
> > this use platform_get_irq_optional() instead to avoid confusing user-vi=
sible
> > error logs during boot?
> >
> >>                      dev_warn(dev, "failed to get IRQ from DT\n");
> >>                      wdt->need_irq =3D false;
> >>              }
> >
> > [Severity: High]
> > This is a pre-existing issue, but does requesting a shared IRQ before s=
etting
> > the platform driver data create a race condition?
> >
> > A few lines later in sama5d4_wdt_probe(), the driver requests the IRQ:
> >
> >       if (wdt->need_irq) {
> >               ret =3D devm_request_irq(dev, irq, sama5d4_wdt_irq_handle=
r,
> >                                      IRQF_SHARED | IRQF_IRQPOLL |
> >                                      IRQF_NO_SUSPEND, pdev->name, pdev)=
;
> >
> > Because the IRQ is requested with IRQF_SHARED, another device sharing t=
he line
> > or a spurious interrupt could cause sama5d4_wdt_irq_handler() to execut=
e
> > immediately.
> >
> > The interrupt handler calls platform_get_drvdata() and dereferences it:
> >
> > drivers/watchdog/sama5d4_wdt.c:sama5d4_wdt_irq_handler() {
> >       struct sama5d4_wdt *wdt =3D platform_get_drvdata(dev_id);
> >       ...
> >       if (wdt->sam9x60_support)
> >       ...
> > }
> >
> > However, platform_set_drvdata(pdev, wdt) is only called at the very end=
 of
> > sama5d4_wdt_probe(). If the interrupt fires within this window, won't
> > platform_get_drvdata() return NULL and cause a NULL pointer dereference=
?
> >
>

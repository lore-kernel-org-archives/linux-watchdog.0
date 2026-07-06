Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F213A1686
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783331611; cv=pass; b=Egtl8kf7GKNSghovDUTR38+rreSXO/SdEmo9HllT55QzFRi40unnEqJiL9N/74jdPuc7SCBa/fz7PcIfFIJ2+sLbT9PeAP9+JHPwfesscHP8v/1lzS99PN3bM1l6ASe6t4S1tytHEfY1G6l72AgX7nAAwSYuSHDoeDnoryZgD4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783331611; c=relaxed/simple;
	bh=1y/VyBqChORatgg7mbBlbrll73whp3RgKHcndf4sJ4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYpZV5xqNhvU1w6tPRGMNhVoBNT/S4i5BuFjKDqxUfxwwRgFxRHnWqlF1ChP3Sa91FuAVRN3vYcytJlXc1c0Gysx47s86QsLMyyZom32itYvttCl9fsUgMWN2YLEytvIO5QYTnhitA9NiFNDXWInkoMudNy+HP5uGUTJCDvy5/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuU0t9+T; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuU0t9+T"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-809b19a7f25so36516247b3.3
        for <linux-watchdog@vger.kernel.org>; Mon, 06 Jul 2026 02:53:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783331608; cv=none;
        d=google.com; s=arc-20260327;
        b=JzzO6LCHiRkbj3ECbi/M9PVE9H1vueJPphrdPy149LvuQ/PKS09fUzB/LbofjgUjJ/
         bcZC6/s3EyXaOinp0qmKzx3c8XFJdeCSFFLxYBJqIcYqnC7kfS+NyESHiKXvxunrwE5f
         kDf+QgXX/ngWTXTr6yF6se3RtDO7gGv4aAewdKd6qHNKrIC408tKsP0+F2a3LzShlg5N
         h/w0PAyWN31YBmt4d8kaAkhJNWTciWdlb8QPIjyJy0iGhA9a6tV3Dp8icmvEupw44c8+
         ajsN2ymPoYgjlwtsar5xfMT29W3YSG+oFDbJICCpW5XvpPYe+3tVRNiv2SHtqeU+NHnR
         eveg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1H5aWjkuNw5NurkeFzN9mtbKO2yqm1ouDy30sVuvqjg=;
        fh=2e/YV/UIPvi299U3q5fESNCC6GPNCUOf2qHBWWLw/Hw=;
        b=GiSpwVEFtEmvEKQwvDICegmKunmjTTNioP1GJ8g9RyLlZk4coE/1qYHdiruBFwj8XT
         40iaLSysAAYfa/g5a5EGzAQfp0ZSHdxQrhiB3qmKzTKAml1XAQr3ldiJQ4d2IpMn+FQi
         fxzV4Ov1Lq9+4/jP0j0k5L5NkZNQc1OB6VNObNE0+wkPnzalpXH+2VF50rSvG4Vgl96Z
         6u+AM5QKeCKS8SOCAHaRyJoWdkPfVqAbY08zv/Dzx6qvmVXxeQuhfJIt50mDTQEz8UnW
         DdYpy9D/Kaf5aXGZF4jbo1dqrlVy604az9V1Fzj/hwpUJBTR6siwFvlMys/+PtMkLCFW
         EyWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783331608; x=1783936408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1H5aWjkuNw5NurkeFzN9mtbKO2yqm1ouDy30sVuvqjg=;
        b=GuU0t9+T3qCj1b7JvMZ1S6qC0sM6V4rNDtDO/aTVqpdQ5pkDr5aTMad9KGQ2rDexJZ
         mJr1FSLwneFMGmI+zpjpVeyG7WO0Ns8SfYR7JwETkqNdqZiWkmIL0bQXujhhi10QLc+A
         sORWYoxVm2YzVvYPI5dDMkRtEe2RLQWgR0KoLtCGO1tzSEWEFqPK89JeTNZpyEXB29Zo
         lbzvrNy1DKWkUS8ilUEnUDbeVE1YkfB3yGenyAYZH/kg8x51CdWxvVIccq5+QRzxjtSw
         MtSz2bzCq8I/fDWF2rRHHzHih4mT+z3hETY+rHms1+t6rk3fMaUZDkM3glWFfPr0kMlA
         tifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783331608; x=1783936408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1H5aWjkuNw5NurkeFzN9mtbKO2yqm1ouDy30sVuvqjg=;
        b=Mbs5fBd8UYIAaP91LDZlAEG/E7NarPA+Z6kfLAp86j9RZZVr49H1yb/XXgYww56Yw/
         HFFPrUVtRHRTOfH456BkKbraDtfmaa9if1twd5ALs8PaNdQPo1IiTVPOYrLhfCOJPQC4
         vLv44s8z1/p4uWcJxwsDZmdqC06BgQ0xaUafcER7QE1Yc3LCNmdCGYOGsjGNNCJaJyGi
         xuFT1yovDcjhfmsOisTYqF7BvxBJxlzSa+ssOPxrPU9McYW5zmtYRbmTVuv1ywv8Ecg7
         3ce6aImkmGbGZEbyIqvagiJ5Dr/9VijWoowx6ppoRcE52Tj5Q7LI9N1jcdWyRPZdwJ9d
         vnAg==
X-Forwarded-Encrypted: i=1; AHgh+RoUAjRDh+Y9w9ceuazoVkqNf73TBXdIPpA5nP14JmT2oTmHHrwmIoNznmHKNyertDkQOzop3sU6FStXeB4vPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkuFCBgRJRWR3OJBo/1teadkUUhlIeqpWlTEbwyTlYr5A85RkE
	vO/usw3MgshHJ8545DruuUl4VNarT+7YE7uCwGq6sXC7zCdkAyR1aNmeSfg22GdwNlrucE2GysW
	31job8w3HtjIWgXTwXDtfnRyiwpDPEop1dQ==
X-Gm-Gg: AfdE7cnoieiq3WDMeMlZTLbPPBfIpOC87CC/wNj0DXBRN7r0eb9/Ch+Mpws5ehV+YkS
	SYPLejOrJ9x0mqIPjH6khhy7IYhB7ztmHSaLQfQZ3KDs8QGOYRxpFJqn17DQYb8x0SQCdPYzETc
	SoV+g4fVsq7dbmj+5TRxQ97nW1UDjNo5u9YhID55dqPYhOsiSp8iOOdeHOqJBBt5tMCLDt74yy6
	8jRYc7aDra+tflMgM0o99H0GdgTnmfg/O7tFK8oLoup2akf/gdDhA0wpeHRmUTiEP57VprWmQ==
X-Received: by 2002:a05:690e:1408:b0:664:e8ac:21cd with SMTP id
 956f58d0204a3-66652e50610mr9454023d50.25.1783331109980; Mon, 06 Jul 2026
 02:45:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260705140100.1543486-1-tmaimon77@gmail.com> <20260705140100.1543486-3-tmaimon77@gmail.com>
 <20260705140617.A71F11F000E9@smtp.kernel.org>
In-Reply-To: <20260705140617.A71F11F000E9@smtp.kernel.org>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Mon, 6 Jul 2026 12:44:58 +0300
X-Gm-Features: AVVi8CeAp4CE3AWU4FV6AWJHL_1TkqiIDqOBExjjPuk3wMGkf3cx2S3XYhDqvP4
Message-ID: <CAP6Zq1jT-bfHvw65EsDKdqMCLVK1Yw3dd0NaxpOCw3zx+hVMTA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] docs: watchdog: npcm: Add reset status description
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, devicetree@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, 5 Jul 2026 at 17:06, <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] The watchdog driver abuses standard Watchdog UAPI constants to r=
eport non-watchdog platform reset causes, violating the userspace ABI contr=
act.
> --
>
> commit 72fd6c8b87d96376853f3dcd5ef1597495cf9817
> Author: Tomer Maimon <tmaimon77@gmail.com>
>
> docs: watchdog: npcm: Add reset status description
>
> Add documentation describing how the NPCM watchdog driver reports reset
> causes through bootstatus on NPCM750 and NPCM845 systems.
>
> > diff --git a/Documentation/watchdog/npcm_wdt.rst b/Documentation/watchd=
og/npcm_wdt.rst
> > new file mode 100644
> > index 0000000000000..cdc45ade9e0d9
> > --- /dev/null
> > +++ b/Documentation/watchdog/npcm_wdt.rst
>
> [ ... ]
>
> > +.. list-table:: Reset-cause mapping
> > +   :header-rows: 1
> > +
> > +   * - Platform
> > +     - Reset indication
> > +     - Bootstatus flag
> > +     - Reported meaning
> > +   * - NPCM750 and NPCM845
> > +     - ``PORST``
> > +     - ``WDIOF_OVERHEAT``
> > +     - power-on reset
> > +   * - NPCM750 and NPCM845
> > +     - ``CORST``
> > +     - ``WDIOF_FANFAULT``
> > +     - core reset
>
> [Severity: High]
> Is it correct to map generic Watchdog UAPI thermal and fan failure flags =
to
> standard platform reset indications?
>
Yes, it is something that was already discussed with the WD
maintainer; This is why it is mentioned in the rst document
> The generic Watchdog API defines strict semantics for its status flags.
> For instance, WDIOF_OVERHEAT means a reset due to CPU overheat, and
> WDIOF_FANFAULT means a fan failed. By mapping standard SoC reset causes l=
ike
> Power-On Reset (PORST) to WDIOF_OVERHEAT and Core Reset (CORST) to
> WDIOF_FANFAULT, might this break the userspace ABI contract?
>
> During a normal cold boot, reading the SoC latch would unconditionally ex=
pose
> this to userspace via the WDIOC_GETBOOTSTATUS ioctl or sysfs. Standard
> userspace monitoring daemons (like systemd or wdctl) reading bootstatus
> might erroneously conclude the system suffered a thermal event or fan fai=
lure,
> potentially triggering unintended emergency actions or false alarms.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705140100.15=
43486-1-tmaimon77@gmail.com?part=3D2

Thanks,

Tomer

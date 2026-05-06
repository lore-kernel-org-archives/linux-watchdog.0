Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C382DE709
	for <linux-watchdog@vger.kernel.org>; Wed,  6 May 2026 04:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778041490; cv=pass; b=APSvG7AwZj16MLP+nYTFQFofJpq4byJ9/kHuIas0s0iZ71ZG/Aeo24n8ju7dnesZJtjfYtogf0oRacINz1qrf+rPdhDeZCv7SQPAKrNIvIvK/BhjihzRKqI1eOY1GVFj2shXEi5/ecYOXckzPmf3kSMlsBYKpHHEHjIVBwzLbD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778041490; c=relaxed/simple;
	bh=g5owKb1Ma8FV3PMZ/IPm/mfmcAADknef5x+8hJdV8Mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5/hHcBNvtrWgwzR9Z+DMByJi+q2UVd6tDiUKo1n0MuB7e/XQF0luNr4eP8g45OkjLUu0PQUClg2PVN1ehHDSEweu/s+h4Tm6ujRo80LQ8OZ40ykgpmeTTPX19Gy+z4cyjZhe49Drkdndh/IZqEFpd0E9H6ciroiR5pLNeukm3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qyQ00oYl; arc=pass smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyQ00oYl"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-8acb856a674so7525716d6.0
        for <linux-watchdog@vger.kernel.org>; Tue, 05 May 2026 21:24:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778041487; cv=none;
        d=google.com; s=arc-20240605;
        b=IK6hcxmngQl24kl/93wBoZMlP8vqP3RhWN2iuHT8JVUKPL5eNHopKTWg9Fl/0BiASx
         0cKJEqlrrHU13pIzgSYtrPGrWQHs8pr+4fE0aUEMhNOiLNeHMgpp/rng1wPeVp/f+O3i
         paJ0L+BA5Z4vaV/AK/xJHO8bgtGJusakIYnu9oX33I7KKVyrVLH63HpeWshfLhU6n3SE
         rlV6/gdLC6JxcES2+6aFHiaf7V1HNJ/y9Yh6b9hs5mMtmxlrQoiZua3HbP8pu6aggaXa
         JzcU84nw5Wwvzx/tLXn8eyQyu+zwrqw+7hj8EIdj7cphUe22qz/4nGcccWM9RjPQFlSp
         bdSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g5owKb1Ma8FV3PMZ/IPm/mfmcAADknef5x+8hJdV8Mc=;
        fh=7HG9OWsX3nsecBo3pXm2tbmZfBmw93ZE3kTmInhb8so=;
        b=geMS1TOu1rRk7whmS7iaXIlsvQfSUufX7cuu7YcUv7f6btYJapuSw85LM/fe3tchkO
         OKXMbbPMCw7WyWdt7hZFnPCwJR8nIavPb+YOXPmLh18e79L9cin+r26i1WbGB7YTZDuL
         Wl7tNBW3IUpJaQkF/iu8pKsZY0PQq3GR4wVzRXhZ0hGNFAT4lx8LeSbuIIflJMzl0zx4
         J8OWFVmrUyVnOVEt9G930qKXua8SXc69qfwMA1L0vynh4sjce9ReQPg00om++aSUdSgo
         2Z94znr9L4wsHF1A8FpfkLsggUjfpcOlr7i+Sgxd18Ynn2p8rOR09Wy3PZaOX9GcnYQ2
         rsbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778041487; x=1778646287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5owKb1Ma8FV3PMZ/IPm/mfmcAADknef5x+8hJdV8Mc=;
        b=qyQ00oYlF/tarZ0VnjUDC6kGsR+bAMWntUNHjFFMxyCnYRCkdysG1TSJRG5NzATLbD
         Ttg6P4ETQc+k82EMsEPrSqUe5voMYYoISHQTAruYjD0dzb1uetNmVOqiBgsbzXRbDBKI
         25nfX/FjgSp3QpEJqMpx9O9tat0onErIOt8V7OP/z9n+j7/CRj2H+Jxac6T641LSbw6T
         oE3aGVRvQdqqk0TedHJo5aC+drqfX0BtL62PAOh7X6hx70XFEJHOJOxbOVn14EgwkVig
         axIct34kf1H6dKgdCJ7RnYKO4aUUNpejFP87vryu+p7adCUcd41Ix3dOLKAVwS9tODU+
         GkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778041487; x=1778646287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g5owKb1Ma8FV3PMZ/IPm/mfmcAADknef5x+8hJdV8Mc=;
        b=LgYwHJixIMI7BKXzQiWnRpr1D5/6Jwwa+BPlfrCovytng02e8WFsATZAuQ+R02bt42
         oocX61mt11NCbH3o4uIatN+hKpiIb9bQHbuzv+QnP2uZBD25++j+PzoIbaiVIwH3Z/9s
         PXxWb5YuQrmISCEebmu2xc1vRDTujdzAuGzMVYHY3ddxKevFG27/JH0DBkm4fKg9U7WX
         7FWxpJKzeHBdJ95WvZ9hCEgg4vgwxmdru4E5Zqr0S4/xA0dsf1q2Gn98t2rojDEYD1hE
         Jgm2MDDcCN67pMAQUf2AFhSQEmApydTNFQI+Z7iIp7+AC8sgJqJVKClui6U53Ieb6bc6
         FvXg==
X-Forwarded-Encrypted: i=1; AFNElJ89ztX0zO/iioiWhdv5B+i7SKbgq4PnpiyzR2HSjvYsChbhxOjBScDpmXfTOkKCv2nKNo+f7GXyp3HqTl53Gg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxN7cBu39KgKQ1dHaipLy16ee6k3B0JyhA0R7Ce4C7CFJxHOHq8
	PW5yazLhM75uC5QZS161v3giaKxu7yX4u58mqzj1WqIjFZQ7tUWv8mumHgtbtv2YERTtZ6zmYsR
	2DNNuEpJ9Fq9dASHCHSw8lfbJg1pJzOg=
X-Gm-Gg: AeBDietd2IUJI8w2KwI4cGFo2+ii8QxLqp782RXDwwM8UeBIE6aVsLMfKIVznimc6aR
	4/PfkjpADUZKtgaZpmw4wVTmu+bLvUgtkBWDFCfP/fTFV8+IW2nQb8PQyVdz335NRrS2vD1NVCR
	S5gXzkFTdmiTEpDpZh4YBjZ/t2ev2hy6p79WJdwy7sbnCt8CqTI/VkbScs4Y3QD2hWECCiulBBP
	uQgfFa/rmrnQJnJDjt0Fm9YIbdOqH0PHscl0NiJe8XTlcmjLqnKpSlTPHwJ4ZT5qhPoXmnwYy8k
	383/NlrdQGxwPBhCNlTn0GtVNjCCcPCi5CgW6xDZhPLjVoiavLp62P3g2CeB9h13fXce1dURzsr
	pbag=
X-Received: by 2002:a05:6214:3291:b0:8ba:d36a:8b0c with SMTP id
 6a1803df08f44-8bc308e090cmr24572786d6.12.1778041486857; Tue, 05 May 2026
 21:24:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428014806.35400-1-enelsonmoore@gmail.com>
In-Reply-To: <20260428014806.35400-1-enelsonmoore@gmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Tue, 5 May 2026 21:24:34 -0700
X-Gm-Features: AVHnY4K0xmgCGjRo3w976y_MhSGXuEJ16XPO6VJddjjCwxbz95nkP8oBBPUwhss
Message-ID: <CADkSEUij01xaqNeFxHX3PRsFCWK7-m2eGH2Knt2T349QOzrQDA@mail.gmail.com>
Subject: Re: [PATCH] watchdog: remove driver for integrated WDT of ZFx86
 486-based SoC
To: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, linux-doc@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 6:48=E2=80=AFPM Ethan Nelson-Moore
<enelsonmoore@gmail.com> wrote:
> The machzwd driver supports the integrated watchdog of the ZF Micro
> ZFx86 SoC, which contains a 486-compatible core [1]. Since 486
> support was removed in commit 8b793a92d862 ("x86/cpu: Remove
> M486/M486SX/ELAN support"), the driver is no longer useful, Remove it.

Hi, Guenter,

Would you be willing to merge this patch? Unlike the other drivers
whose removal I proposed, this one can't be used at all now that 486
support is gone from the kernel - no other hardware contains this WDT.

Ethan

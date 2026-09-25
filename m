Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4633847F2ED
	for <linux-watchdog@vger.kernel.org>; Fri, 25 Sep 2026 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790327198; cv=pass; b=XCvQo0nF68UzrbyJJTVYAMUjBufsQc3aeLMC0u+HgeB725T3BNfbGe/7ubWyYFmXlp2dz0seEkzkzoHkOqRmmUtVvjABm+BA8HsNW1PnOyTgBkGscgFgSWLSL0kdgSRhzDauLAdpi2MAKbr9sGEtPKrX21qqIgfV9ovEifibEKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790327198; c=relaxed/simple;
	bh=vNfrt1r00h69iVK9kwlxNnrlpJK7TpbbLBmXJ3dGSlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4y1FoPclkZF0zKxX/D/IRfdmtYXwxgkAjUDv+goh4kgDiYei8Kx8BLcCLVrF9C7oAwbN91HYPkht6QC+SihS98pcGxa6ihTTce8tXvlEpkLdjIlB6LZdO7ge7FgswbW075TEyZhZ4CvFk6I6FxTPQ9N4GHieMQryhueL/eM5qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8aGv9GC; arc=pass smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8aGv9GC"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887f690df6so271857f8f.1
        for <linux-watchdog@vger.kernel.org>; Fri, 25 Sep 2026 02:06:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790327194; cv=none;
        d=google.com; s=arc-20260327;
        b=gaHwAb4m4gz0asrkku8Ft9Vt0dmA7bO117BJ4H65eWFgdAMA4+KMVoUJj6VDGbh6H6
         iW+wKbDleXHWAwvverg0nMqGbQueDdlcUFEFU38xHD2jOiKziAXb2dAbFMBAjRj5XTxc
         1+C0PaY5h5zqKD4hcR2/CUi0xQ1PkwbHEeIRTsqCc59ztP2N7HgnkI2ShSbCkofXwASN
         vjePXt4LhCe6tcTIuGoHYj6Ur0KSb5e2fm6bfhaUSO2dpVTpFR9mYxnZxg3RG54moAJz
         6HDHs0PCCY4Ci/oRRC/Ws1CUAFH7uXOSSZ3Rk/9NLAGOjm8m308Ih5YaFtERLSJr+HYq
         6uWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vNfrt1r00h69iVK9kwlxNnrlpJK7TpbbLBmXJ3dGSlU=;
        fh=cQ5V8GssX3gsizrikTqEjUFMlXO+tLDXFNuGyl/k9e0=;
        b=MzVCnpj38y5HWAp5u3Fd0UUFsjaiI7BodIF1PAe9MokDimOYxm0KXZvk6KVUZxiVkc
         SL9HDj9KjHm/ruly1zqSd+Z1nge1dLfW+kUCC4yAY1OI+ap7DXoaPfT/lFzDx362ZMqc
         ztsudzQYWDpr0Mox8UH+syeaKlut2YlZ2orZjSX+Kd01en6tnxW6+dG7QANnMP/wM90S
         OxzkFH2EI68CS0Wi4BSNIy25kYp45/P0NhhJCXJydveNXbz/RsrWaqMG8VYNNg26/eI5
         EL44MgSS6ycRJMuCJqQvEdHvxqlsu0/jXR93XX+Cqf1ymjI9GXYqZLAMpepR9T7aqSb3
         E0pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790327194; x=1790931994; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vNfrt1r00h69iVK9kwlxNnrlpJK7TpbbLBmXJ3dGSlU=;
        b=R8aGv9GCEXuCBoR5uWOBG6O0DMiO9/8OiajQluEPoHpwUx9vcMS24D5M9+sk/imAXX
         8nPq32hQlxhmrLOWD48KB9/a3WlS6w6Yi9z9jVinJPUOkHhau8C+dpunY8exj9m4cjyL
         s3UrGSPz5O3K9IKq6NVTGiLNMkidX0JwgVuZwHEBDLsxw1N/Xj9e14iURX7uzSz6s4sj
         Nre5u7UlA5ITlaLCr7H57BJjGvkGVoGhjOfXmGMQAeho8DCSxIbg4TDo8sxr0TkhwOnd
         BAFrlWRMOfuTfHIRR0az6h55Fus/wsnzNUpa2zoemv+tUNH30LOX6i3FDx5sz+92WBKb
         LYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790327194; x=1790931994;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vNfrt1r00h69iVK9kwlxNnrlpJK7TpbbLBmXJ3dGSlU=;
        b=zaJqYNnC90Zra692RxIJxd1kHYuNMI7e18gHNLSGS8EDtoTWN6f7fxL9scGi0ru7AE
         nBNIciHiP69YxFujsKr5UR+9JT9JMj0eqgcQl1xHDilEzCRewwnx/QjTigN0UBsF9Cor
         t6CwvZ3Mm+JaaOtx8YGGw/Sh1whmwu3K5PwFUAKG7OkVi3UizzXdTLrvefCF/ZWKimN6
         wxwsltMmtIkZzEnbU3oyrvPf2n1j3ZOVRRys6PiFtCAZIfhXrD5UcGDs0FqaR8eq83ih
         dsPhGbdtoxXrbpbZL6hevsvQCEjp5ZA2v3WB1P2fqLqWwJ7iexAsVOiujywmkm9qg5yD
         /QAg==
X-Gm-Message-State: AFuF++mnS/k9vkvuN5fWTRHXgMaioyKAz3o/c3So2VFAUmX/ur6AZ6Jt
	CrlYM+c8sYvDLZWi6sKDHVaFHZq1/4uSsMZiFcqhYMFIDdoKmHdQOsAG6V2rrg7IziITyGznudJ
	dUE28GNMZbMVrixNW5BuQbnHeWTkSJno=
X-Gm-Gg: AYBFou3LlTb4TJ5czSJtUBawrRWRQItwnTLD9A+57NH0sjn33NNE9lBoE8vbmTzB5D8
	XJmKgds6oA6CWZgjJssVvRza4+V23Wkd4ZYW0L9Jky8r+UMG2LflJWQT3g1s8WP9zSZ7X+HoGS2
	qoGlEXcSnpzEQT+b3NaDVNZMxKIv0jHSDOnSUy/F3EmagCL2bBBKrOBKR748YICw5LFaXLJF+mp
	nsSmCzjC9eUwzHsZRgohb68mhsfA8S8AtTp5SaFcsVK60vPNKPh/tLBTogm6yZgJjzE8YiXge5q
	mZJ7ejRWclniw/xBLDzhA8IGjoXcVlzYQrIwlzeYzrYPDly0DRMN8X1jaHTWLu2W/zs6quES8uo
	Gk9VxACtwBSraUSHWl7/qFPcvqygOW6nG+gUILJLGnpWGhVfOquspfvO8Ii6XBVwfPCUPuIVU
X-Received: by 2002:a05:6000:40e1:b0:487:62d:37d9 with SMTP id
 ffacd0b85a97d-488716a5e3amr8597568f8f.27.1790327194104; Fri, 25 Sep 2026
 02:06:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923104054.3324830-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260923104054.3324830-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260923105237.7B87D1F00893@smtp.kernel.org> <CA+V-a8uD16uG8cc9m7NHVZXT5bU64TYfu+_1POuXeioRAy6Z+A@mail.gmail.com>
 <4f5aadf0-8f23-4871-918f-430a0c99900d@roeck-us.net> <TY3PR01MB11346CC8B3C7374C293E0F3EB86802@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <2d32d7f1-f87b-45b3-9ccd-95e9773ca658@roeck-us.net> <TY3PR01MB113461EFFC2B9B39A53ED1D3386802@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB113461EFFC2B9B39A53ED1D3386802@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 25 Sep 2026 10:06:07 +0100
X-Gm-Features: AclHuK_cnyrPiFUC-mGji0jHGuw7oeqC1g44QAFCgRUUpyFQSgbBoQ_H6jT1WEc
Message-ID: <CA+V-a8t3HKQ6D8jb_y-XM64BHkWm3vRw6JiTydSp3rqVr9nhdg@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] watchdog: rzv2h: Add syscon support for WDTDCR
To: Biju Das <biju.das.jz@bp.renesas.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Guenter Roeck <linux@roeck-us.net>
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, 
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"wsa+renesas" <wsa+renesas@sang-engineering.com>, "robh@kernel.org" <robh@kernel.org>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Biju,

On Fri, Sep 25, 2026 at 6:11=E2=80=AFAM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
>
> Hi Guenter,
>
> > -----Original Message-----
> > From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> > Sent: 25 September 2026 05:51
> > Subject: Re: [PATCH v6 6/8] watchdog: rzv2h: Add syscon support for WDT=
DCR
> >
> > On Fri, Sep 25, 2026 at 04:13:24AM +0000, Biju Das wrote:
> > > Hi Geunter/Prabhakar,
> > >
> > ...
> > > Just a question,
> > > For automatic software upgrade, if the reboot using PSCI fails, what
> > > is the fallback for reboot, reset the board?
> >
> > That seems to be a bit theoretic. The reason for having the ability to =
register multiple restart handlers
> > is not to have failure fallbacks, but to have fallbacks if preferred re=
start handlers are not available.
> > If the PSCI restart handler is present, it is expected to work.
> > That is why it has higher priority. The idea is to use the highest prio=
rity restart handler, not to try
> > one after another.
> >
> > Sure, the failure fallback works as well, but that doesn't mean that fa=
llbacks should be provided just to
> > provide fallbacks.
> >
> > If you claim that the PSCI restart handler does not work on this system=
, provide evicence, and we can
> > discuss this further.
>
> I agree normal cases there won't be any failures
>
> I never heard about PSCI restart fails. But have seen a case due to a bug=
 in
> serial driver that made the PSCI restart to fail as it hangs the systems.
>
> So, if this is the case, a memory corruption can cause the same.
>
> Long back I worked on femto based product(single core), where we have nor=
mal restart
> and a fallback watchdog restart. But it does not have PSCI system handler=
s.
> On some cases, we have seen automatic upgrade failed because of failure i=
n
> normal restart.
>
If you think the PSCI might fail and not restart the machine the other
alternative would be to export functions to configure WDTDCR using
readl/writel.

Geert/Guenter - are you OK with the above approach.

Cheers,
Prabhakar

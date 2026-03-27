Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C7E3D9044
	for <linux-watchdog@vger.kernel.org>; Fri, 27 Mar 2026 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774602112; cv=pass; b=j4K7Q5pYwqgTFY6wPO0zzUTx6DQ0qPWuAu2VWFsVG/uCMXTIQ5w844YDaLSh55WmETLosq0Y7umr/NPoN4KdtZXxGU3t+/vIVNEOgLFJtOSFJ6kv8lmg/AqoGzYmHpbDfHp+SwZRWf4bGUOCZeBeOMUYpRCza5UqAIz5CB4y+Jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774602112; c=relaxed/simple;
	bh=+vbbo24yKq0IDRd2PJ4Kwyke10Z22HzWjg+FVkRJMgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsRfLCQ6gpH+VZLB6Bzi6ALvjbyWbSiYnbwikkngJprVLdVCTTILTUI4vBmd4DpxatMAyvp9jqhcZlUp/w6CD2miSjKaC8fc9DedCROSSPWGBg22EYJR8CngX/kwwJQz2v/pCk/KsWkDNkjn6twlzvjQNRFunWKZIrbmqvss8NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cD1WToTM; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cD1WToTM"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-128bae6a35aso39361c88.1
        for <linux-watchdog@vger.kernel.org>; Fri, 27 Mar 2026 02:01:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774602110; cv=none;
        d=google.com; s=arc-20240605;
        b=Dg8htLzNdl3ZW7O6+WARS9vYYzkuxU4+us94t3u2NhEPGNPFRngGodU/3qXNCMiQ9+
         QzrBXsLBUqE0Zw7FsHUHTOpksp2aXsqKmsAqTMoE8kCeaOLdwODVvXzprNyyuCZbXx1b
         8Ja5GXYuWFhp1NeaYtVaJVcWZYgDlFlRZw7SUMij1Vw4CkFZetreSn0d7tDeL12Mi+iO
         AsJENvn+QkEIfirW0BibNT0deG3tOLDspkis1cWfs/48orERpn9oGNTRaBwrfx2qWoCM
         rkQC5J8cX5FCkwl37mBgXIHpju2I6GCFk9vaM2dytcYS6dTMBwr6702m3zjFHXh8jnfu
         j/Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FXbx06b5gGwUCi6E4bAqfsWHp7LT3go+/CbGA5Bn/zY=;
        fh=hyPjI5ObVfVzdslSl0gAu77DwnYgtkVDV3iQJEsWcjU=;
        b=lbYQz9ZShLKaZ/ULsrC1SySBVHBfSDpPm19G73HLr0plwADVkDJPauVNHBe5DMhhg1
         qYW6QXXBYyL4FWIpJ5Hxc6PZZrpYf+2mdZh3pBNfodzEouLocQ6b9YEsEKQSTWOFiBdy
         0edL5Htqnsjn0z2Sbkxap7fvyIAvWmg9IqtFYmUAyhnLGnzZu5+jKH8JOPLEOHH6LqVp
         OuYrNn0PKPp3qc4vuWzj/SVblDp4PWg/GUhrGE5NV6FbVSrL/F+JmtN0j8zOrHGTCQUF
         iXhETFnZ7XQGZtodtESsCRQ/9k733zvoid2xn0O6DoRukkmDm7yu8Od/q3L+pPtcgDrA
         oCTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774602110; x=1775206910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXbx06b5gGwUCi6E4bAqfsWHp7LT3go+/CbGA5Bn/zY=;
        b=cD1WToTMq632dOQHQqXLtmFxgvlp6ZGLpXyYZOoRoWyqvrHdx3g3g48zw8HEruwB1Z
         V7hfh/iSzF0fl2Yyn+kKYP3fJyJAa7hMo/MTCPB3jB9o/v9nVU+7jmJDHarWg3TGMjav
         tQ0E7BvVgi6TVtua2GESboYjOIt+AF48qCaKenuz3m78buvh+HiCvUlqmUXa+pMAu9mQ
         Ecyi/S91F06LGibiFNMeclleoPQMtfWxHnI3r++BWL4M57/I57eeUhsmRF4v0iDWAKJv
         7ajv58hj8m+CZYQwOML/XYCS9Uc5+8eiVLsXVoeVPM7KcLVf5XnWxdNxehEdqlaCY4mD
         J5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774602110; x=1775206910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FXbx06b5gGwUCi6E4bAqfsWHp7LT3go+/CbGA5Bn/zY=;
        b=OUbGXcWPhgl24nMgCRjVk02bfNsosnoqAJetTnQegBD6QOgYW7AtCfv1eYA10xokwZ
         RYKh0cjXxHfpAfYFX3CzE5fTRZan+MaCxZsj3L4W2Ccf9ljzgz/bYuww51IxDPxy+LUJ
         NEHDJngMHgEU1DIUV9CKX52BPqNK+MT86odva8av4v6EO90HSFE1MYZLX+vDqYMpbydI
         CiKs0uP7T8e77WlWn63IUklQeejfGfL411r2o8iR/SSRrwzHRcnhAOQagNN1jBJnfDab
         lO1OAmvFEx8gStSL0kqescakvMPyPfUJl+gS/BCLQBGbCqrICHDxIpHGtWVP4VKJKdyI
         nJYA==
X-Gm-Message-State: AOJu0Yx0RoUkCG9vbwg2WFOD5RiRBjc+MCWstba/GckFgAXz3PJh+NLa
	hSvn9iULpM+w1GVjojq2pmgTtilZucWulIRgF+DcERgXpYpCxNL2zxG5dsRdliSl9aiBJoR2cuy
	ddu7YF3TDMk8TxaavHyHRwHpdLzmLCm4=
X-Gm-Gg: ATEYQzzZaWQEZm2BYE+C25SZTdjLtEa5hAajx46fxR6Ts4pX7q7S3zIlYIexgDUDGhG
	4A4FNULewo9Hp3Xp9Rc3jfNop8J936vGT59YFfEn42nNkoA2HEN/sckLHhKhidjRG288pEFyRy5
	z2xyLuyni79c2imk+6PdnD9ff6TkcW+O5o77WuzIMX3ewLqx9Uqo1fseJKO6zssToHyo7WQNZcI
	5DIEo9iy4XJZsMD3bFGEIBRvrTSWrX0Vr08m+BV3GoG64AANOaLuYBrvE7CW4dfeT3OIVXV4OPg
	TbhpMYKQN12cXp80dL3ODRaLYPt8TjCnjPb0NeZ3gMB1xPh2650LzwPHEQzOHyOVswCjE0OFp8X
	DowsP2Zk4gSitYlJoJaK/gh4=
X-Received: by 2002:a05:7022:4387:b0:128:d279:b8ea with SMTP id
 a92af1059eb24-12ab28f3a8amr456230c88.5.1774602110054; Fri, 27 Mar 2026
 02:01:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323195138.5541-1-iprintercanon@gmail.com>
In-Reply-To: <20260323195138.5541-1-iprintercanon@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 27 Mar 2026 10:01:37 +0100
X-Gm-Features: AQROBzBqoog5a-kiwWEmvD5rpeosZ9vAQz8URag_Abuclk8cdHKqrhF2-U4TB6M
Message-ID: <CANiq72=TGv80K9Z=VhWkh392oCZjSVH=W5JsmYgKR1D7k8yf+w@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: watchdog: add watchdog device abstraction
To: Artem Lytkin <iprintercanon@gmail.com>, Gary Guo <gary@garyguo.net>
Cc: linux-watchdog@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	wim@linux-watchdog.org, linux@roeck-us.net, ojeda@kernel.org, dakr@kernel.org, 
	aliceryhl@google.com, a.hindborg@kernel.org, lossin@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 8:52=E2=80=AFPM Artem Lytkin <iprintercanon@gmail.c=
om> wrote:
>
> +bool rust_helper_watchdog_active(struct watchdog_device *wdd)
> +{
> +       return watchdog_active(wdd);
> +}

Without commenting on the rest and before I forget: these should
likely be marked with `__rust_helper`.

I added a comment in our initial PR for LLM prompts so that e.g.
Sashiko may notice this sort of thing too (Cc Gary).

Cheers,
Miguel

Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEA124A06D
	for <linux-watchdog@vger.kernel.org>; Wed,  6 May 2026 04:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778043539; cv=pass; b=FwkcuKV8Rq6L7po8eOYY2DlcusXjDJkEsfku4pbQ0vf9oBovDfunqiHqkFNzp8tLFG97ZZRHZl9YbaDEUFormsuEdUONUbzDGp08iICTH4Yq0rE6daZE6hrMMbe6mzEP1tGrbq4JGe0DZSyUax2EnajmsqCHnhWompGfvXtoOlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778043539; c=relaxed/simple;
	bh=b1BbcLLXm5jwT/2UaCnWGJGlW5EMRKxSPsM2zIavL/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMSBpSBguIKiHkczqRJiWKAIRD8Zb1/+nMvJ1faikCbLJM7KTCU9xc4l0T16stHcdS1/Qkes1BzDvpzG5nuqkaTLWkaNaJwNy06kAhWIai+GUq/pW1KIuxw8wNV57s6u5Vr+Jbi1aUUgBKFS8hUDNL153q+yNhrX6k8f0Dt4Qeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/CwXw5+; arc=pass smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/CwXw5+"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8eea23d01f7so806388885a.0
        for <linux-watchdog@vger.kernel.org>; Tue, 05 May 2026 21:58:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778043537; cv=none;
        d=google.com; s=arc-20240605;
        b=DOBKv7zEhoKhC76Iy1hALCN8GFViw5TDGcguwQsvkMpjbBwJTDO+jXi2BWlYnOosc2
         e1vFckikuO37auIWI6wmzpPtKjuaTYItwBo3oxNjgzrQv1xcwtZIxdjFcRObfEgaDoAj
         jTP/uCQehCmWfR7Vf6igfg234VK1NU7aNdnGY3g0C0kuMhR4pQMvdiYpeEXv7iHtIVbK
         /bgHiQbXP3yIFjtv+TiBTnBbLbCo0YvpxNRaJG632U5VrUbigruLOiT4BDBmugbA6L/q
         IxBc+yK4dFN4IA1NpjyCRBLSQVKi28rAMZVy7H6dRk05qHGh80jvZDPzUe23a5heBJ/1
         Da4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b1BbcLLXm5jwT/2UaCnWGJGlW5EMRKxSPsM2zIavL/Q=;
        fh=jf07IPlpWQ2Q35VwyJA0kZCp9F9tc4PSmXTK2cDlW80=;
        b=JdxSkLLhinWHairSx1aJE6TD1qy0/37zupQAcF3M7DTs2f+0+A1SshM/dVBK/hYevW
         6FOHq24xn09C9BR9ThKCNLXwQCXELXnCcrwbwM/Vp4ehzobVKC5s9hy5CWM/tfXGpD0V
         d+W93v7aVNZRiUaCQWKt/q+psYRrFKBNZhQ8tDRUYToDsXh9rW4Bqbq3hDiuE0YE8uoF
         RxKS3lQUFWFdEvjb+aiH6CC2uQ5TMC9Caj8FHbirT/+dmM2VtCOOwLyQ97oDmIM4PoQ/
         62SRoxD0roWUGMlgtcTZeTsrVDTNtjc9N6nbiZkqPTeFu55M2Efns9IRYgxFXXN5HTZ4
         BKsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778043537; x=1778648337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1BbcLLXm5jwT/2UaCnWGJGlW5EMRKxSPsM2zIavL/Q=;
        b=S/CwXw5+9JMDA/1WyrKiYpmZb5BvVWHUikiL9NdlaZT8er/Xg61WWbM6kg8tQ9cZMj
         /2h+arLKVFReqGSTZb0OKkkRZW/jXVBbe6dKrKm55LVAVy5oxOnCIVYoVxDCFJf3P4MU
         1gsCBXd6PO6VEdXKWWDJ1oMj9XxsqahFy/NpnLSKXtfy6h8S252wNdgRxoLdmQ4+eYG4
         mP+QPQ0DKeIJoHxOMYjwQB67HbCqQATlq3UiWH9PITJ1lOn5k5UnbzfAL9Eq+tsWjP05
         1tsbxEmPFfDcL1xFlrzffNT0A+jkzFhHevYjt0ziaZL9mNd3oRhNZDzIi9rw2PNKGxf/
         K1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778043537; x=1778648337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b1BbcLLXm5jwT/2UaCnWGJGlW5EMRKxSPsM2zIavL/Q=;
        b=hE3TIOkAF6ox1qxL4JnTzXkUmpNFHyg0l8O9Tk9zVuqt4brAUEp+a11XP1p15n6XAS
         EXxffkajT8LZGPd+Z2yLtTJTDDhSJmyS24rtOYOMhIVxg9NM6naeDS2tBgxVa5xFTQ/G
         8Vrqccyxs26ikBE8qxelW7UFiKP9M2BU2SKTkM3PyqSFt/gDSR/xh72pR+svfpjylGsr
         sldlysjFpNLOEOdK/wpHsD3OiHJRkAcgZuK1V7vuPhSDYKVHE4iGmdCkUUxJVo3BUPvv
         /pMekKPEuJ3zJz1wy8ikPWr/4mWJdgrNtQBS4v1wesAxXFdUhPp2QgnkXrkdrZoqsMg9
         o6Cg==
X-Gm-Message-State: AOJu0YwfkTlz8KrlLyfz40oN6pyuIYVXESnesv/ibb2ZTDtHXHgrBxRf
	36xOaLHSPbk4xeDjbZ6gtqPOBN4Dwsu4R1k1R7//mIDA9aVssVJs7zS6ikIKPBASydEkJoh5pIK
	LtEgdk6oGlymbSQ8H6Q6NfmdSlW3s1to=
X-Gm-Gg: AeBDiesiCM7iQqzawD8Kz1LiFXHlnPtWjyf+ExCqy+Fzak/mUyTdlSJVcDPSfxQnmLX
	XkhxqJjmxuxHmRmRq7wW3kP2TIERKeAXGFUuZohy5rTibACRw0NOv1wHw36m8mWqHn6V5UvJSeP
	TmcKIzzvOr37uaGoFI7gvK1/xhX4DpID7UmmK6hTzfavFPVn5P4IMDA7hZ/tF145fTKsPGo5PHy
	ElON/XTu3wDTvpSdsKLoFjQyhPaWIdEro3colA9rhPJ+xFVeCJphfOxTwnFrb1FITyoWQV9v3TS
	At7doN88kayWUbHBK4lYwgWFG3uCehS8zfIZHLBlK2XvFqyqe4m9DMGR4XFuGaI8sDDP6di+J7F
	/faQ=
X-Received: by 2002:a05:620a:280e:b0:8f0:10b0:9e4a with SMTP id
 af79cd13be357-904d6fcc196mr291861185a.57.1778043537373; Tue, 05 May 2026
 21:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428014806.35400-1-enelsonmoore@gmail.com>
 <CADkSEUij01xaqNeFxHX3PRsFCWK7-m2eGH2Knt2T349QOzrQDA@mail.gmail.com> <81a90b2d-8dc3-4466-92d6-936679e210d5@roeck-us.net>
In-Reply-To: <81a90b2d-8dc3-4466-92d6-936679e210d5@roeck-us.net>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Tue, 5 May 2026 21:58:45 -0700
X-Gm-Features: AVHnY4LBvePXvl3QJpoL7mQcwuHEx0Qh7nNp_v0LV_n6v7vLjZrVBYqOF632V8c
Message-ID: <CADkSEUgGuyEt_GD5yPaQSAR-6f3Vr6FF1fjatkXcA3V9MOB=sQ@mail.gmail.com>
Subject: Re: [PATCH] watchdog: remove driver for integrated WDT of ZFx86
 486-based SoC
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 9:53=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> w=
rote:
> Already done.

Excellent. Thank you!

Ethan

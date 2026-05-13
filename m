Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F095B28505E;
	Wed, 13 May 2026 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778704710; cv=none; b=juou/zm8ubbjtM1ObmKt2KBLqMyNr2+t5bBlpgHm110VvceYWqs5tgs27XUCwgKW8kp2trb700ZAAV4qTxdHqadOi+pzc9/PCu/YWvLOteU2e5ZQq1y+HuhdNDEEl/kBjHJhU/gRyR46iMULihsDH6104vx6z3T8xgNkgcdFXNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778704710; c=relaxed/simple;
	bh=zk6v4u+WD6gb7CASDwDlzqfd+4gMfF5qsy9MDTGznzs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MFpyYp027hV9dKJB4XJvyMaiCuDBDyGrvo5L97bBYTxPFcM3k2VqcgCA0FQYnvamWIhPo1+zDW/02EqfZS2OJeG+mZYA50f3lHDOsJmKh3OXDP+CeB7ysOv/1bkRYs8ZE3H9UTVAmO5psxLJZ39WCMufH+AOt63kzNHkGlYmz0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gg6zWi8Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gg6zWi8Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E10FC19425;
	Wed, 13 May 2026 20:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778704709;
	bh=zk6v4u+WD6gb7CASDwDlzqfd+4gMfF5qsy9MDTGznzs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=gg6zWi8ZiWLG6Wi3BtBTK9A3kpivb5OI3PHHvMKrPzheaQIAo1YOYvEZXsMFlR/Bw
	 JQMh4TmrL2tk6G1WWqvpos7f1EEMAC81tYhoa0r70A/DK7R5nMfghgbVfSXEnf0XsV
	 FXOmbHuLBzJNNqHxIk2kNQ7gFzCWh6xpaYVo5Be0e5ZYKgcK23drZQZQrfBksScbI5
	 Mvil47ClZVlSgO//a72ufieg+wYQtY+G5pAIMde8G7RCs/wvW4e3Lfw1IDrYBp8iK/
	 pRoZWUAGQctrmuCbffCQz8DRk4KLnKO55rZrU/a/UKA0sCc97+W8av/Vnjl5A6k0m7
	 NefYFQgh44HOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: realtek,otto-wdt: Add
 fallback compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Vanheule" <sander@svanheule.net>
Cc: devicetree@vger.kernel.org, krzk+dt@kernel.org, robh@kernel.org, linux-watchdog@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260512110848.106620-2-sander@svanheule.net>
References: <20260512110848.106620-2-sander@svanheule.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 20:38:28 +0000
Message-Id: <20260513203829.4E10FC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Improper YAML indentation for the new enum sequence will cause `mak=
e dt_binding_check` to fail.
--

commit a7861dc20069d6726a660807ddc12d7c2ba28a4c
Author: Sander Vanheule <sander@svanheule.net>

dt-bindings: watchdog: realtek,otto-wdt: Add fallback compatible

This commit adds a fallback compatible for the realtek,otto-wdt watchdog
binding. It duplicates the existing compatibles into a new list structure
to remain compatible with older device trees that use a single compatible
string.

> diff --git a/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.=
yaml b/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml
> --- a/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml
> @@ -25,11 +25,20 @@ allOf:
> =20
>  properties:
>    compatible:
> -    enum:
> -      - realtek,rtl8380-wdt
> -      - realtek,rtl8390-wdt
> -      - realtek,rtl9300-wdt
> -      - realtek,rtl9310-wdt
> +    oneOf:
> +      - items:
> +          - enum:
> +            - realtek,rtl8380-wdt

This isn't a runtime bug, but could the YAML indentation for this sequence
cause make dt_binding_check to fail?

The kernel's yamllint configuration enforces indent-sequences. Because these
sequence items start at the exact same indentation level as their parent en=
um
mapping key, yamllint will flag this as an indentation error.

> +            - realtek,rtl8390-wdt
> +            - realtek,rtl9300-wdt
> +            - realtek,rtl9310-wdt
> +          - const: realtek,otto-wdt

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512110848.1066=
20-1-sander@svanheule.net?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF56836C9C1
	for <linux-watchdog@vger.kernel.org>; Thu,  7 May 2026 19:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778181802; cv=none; b=AfHy9mDG8gOunJLUjL1y7cHDUif4T2tfKtGAC/MXuc0B+q6AbLFsstfxudvs7e9CVhhAB4O9q6/r+x+ySVO3tlkEF7L5eVDF54OqUiYdiqdNAY0L5BwObWRXrHMiFVXXd1CTExmZnIyYnjQPfXCSsME4r1+xlEFAN0i77hwlUks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778181802; c=relaxed/simple;
	bh=7B5SU13jr43UwP4UFYEsmSFdIPPq9wb19lfZHEPWCn0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qzt+Sjf7l1AMWLuEeWyh2KP+QtZ2Asqs94iwfx5hSJ0vOFPN33bWP3X7J5bE9TdKLWZ+Y/ymcm9enqDXgOb8+RfdcqlPAqun5yT5v+bCtSKRBfNBrR/j8wANs4pzqpbQy91VaeblmodlCE06H7Y5sYW2shu+HAkNc9xHyd3hlW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvRdb4RC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvRdb4RC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40044C2BCB2;
	Thu,  7 May 2026 19:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778181802;
	bh=7B5SU13jr43UwP4UFYEsmSFdIPPq9wb19lfZHEPWCn0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=YvRdb4RCZ9oVrh1GwzyhnRhXyzxrMIEOhPvlVJye40vorhGKfDz/XNmD40pwJ9cep
	 mLO4PX64Ocicg+hKYaO+2VHoqU7Lz+mrWeqNle0lhOujCMAbiLxloPMTQKGTkMjN1B
	 LwwSB9XLVd2g+Dw6n3fHfVBnG0EiJap0cuKNIn5Q4/G7PwTlmOTLiWPdoE+qc2WGxS
	 Ojpm/T5gav2XVoipxAEWZwQrUgvCIa4bfch8z5pvefBmG3i7Xfmn1nRc22a2Sjec3/
	 kN1qmF78O84mtywyC43vM+zlBZWePywlvs6543Am7AqrkaWNCrvGJ8lxXNUtPkk+nQ
	 8Mwxh/lxh7rtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: power: apple,pmgr-pwrstate: Add
 t8122 compatible
Reply-To: sashiko@lists.linux.dev
To: "Janne Grunau" <j@jannau.net>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260507-apple-m3-initial-devicetrees-v3-1-ca07c81b5dc7@jannau.net>
References: <20260507-apple-m3-initial-devicetrees-v3-1-ca07c81b5dc7@jannau.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 19:23:21 +0000
Message-Id: <20260507192322.40044C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The 'apple,t8122-pmgr' compatible string is missing from the parent=
 PMGR binding ('apple,pmgr.yaml'), causing schema validation failures.
--

commit e33d93e259fcbf5bef9aa91c6bd8faa5d38a331d
Author: Janne Grunau <j@jannau.net>

dt-bindings: power: apple,pmgr-pwrstate: Add t8122 compatible

This commit adds the t8122 (M3) compatible string for the Apple PMGR power
state management block.

> diff --git a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.=
yaml b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
> --- a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
> +++ b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml

[ ... ]

>        - items:
> -          - const: apple,t6020-pmgr-pwrstate
> +          - enum:
> +              - apple,t6020-pmgr-pwrstate
> +              - apple,t8122-pmgr-pwrstate

Does the parent syscon binding in
Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml also need an
update to include the corresponding top-level apple,t8122-pmgr compatible
string?

Later in the series, the commit "arm64: dts: apple: Initial t8122 (M3)
device trees" uses apple,t8122-pmgr in the device tree. Will this fail
schema validation (dt_binding_check) because the parent compatible is
undocumented?

>            - const: apple,t8103-pmgr-pwrstate
> =20
>    reg:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507-apple-m3-i=
nitial-devicetrees-v3-0-ca07c81b5dc7@jannau.net?part=3D1

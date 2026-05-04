Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996523A169F
	for <linux-watchdog@vger.kernel.org>; Mon,  4 May 2026 11:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777893455; cv=none; b=oa+SecSDB8fxzAchAUdNPFdQVAXfoask0rHrD93Y5jkRcYe2OQGvwfBadsricM/7ZrthYauMusXGAgOPKQVWnVz2XOQO3vIOOeBO+3MtMnOeoQpxb3MfaOHrV8802LykCP70vUZ67Q9lSPaZHjb/lcz3BBbfRDQhgTae4XoypjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777893455; c=relaxed/simple;
	bh=MFq2nAa6cv9JZtpwXuFNnopbwoRF1u4SVu/vv2xNDKg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iKxOyPGTWIyJh3PoYnKLw5iwnHWTIg4nLZoMMe3S0JbZzMYDiXh+q0gDL20PlQQRkSBa7TEjg9M2TeQyoKEvoYE/f1wFqv7N2S59ZZts8zGi3u6Em4i5GWoJy6yXLG5rSjiS9dYYBl5eV8K6l3tXRPI/FqS6W+7AZkWpgklcbqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=usqAj4Wr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="usqAj4Wr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D387C2BCB8;
	Mon,  4 May 2026 11:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777893455;
	bh=MFq2nAa6cv9JZtpwXuFNnopbwoRF1u4SVu/vv2xNDKg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=usqAj4WrSitDNXnF9qd2NJXeh1S9uCW5L5NOhZjOCTV/vTHOV94HKnLwYQ+TWvQqf
	 AnY6jkUCarFjeRB/FrCZMJUqnn0UR+ggIuMQOjm0NYqkAxkfWv7+faBDkscjxphMtg
	 6Dbc73/FWCBwVpUCwmhxMrMtF+nUwhq5TKu+UM1xMM539p6xmFGCOCnMWBQe8/uggO
	 cpZig6r4D+TrAOWhrPTzhhk3y2Kv0wLtJBMXkXw9JVNW2zQ5kbdl6yplxaYt0cRu/Y
	 8P/sVc1JS/x4Yt6Tp6wRHWcpEgnlSa8HopqmbmBf5eJD3JlAXeTN8/X79dB+uBtrOn
	 pd2i6iRLMznWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] watchdog: Fix wrong SPDX license identifier
Reply-To: sashiko@lists.linux.dev
To: "Philipp Hahn" <p.hahn@avm.de>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <5557c8ab4a62750c95631f6f78be7d2b11e091fc.1777892508.git.phahn-oss@avm.de>
References: <5557c8ab4a62750c95631f6f78be7d2b11e091fc.1777892508.git.phahn-oss@avm.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 11:17:34 +0000
Message-Id: <20260504111735.3D387C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit claims to fix a checkpatch warning by replacing `GPL-=
2.0` with `GPL-2.0-only`, but the kernel's checkpatch does not warn about `=
GPL-2.0` in this context, making the change unnecessary churn based on a fa=
lse premise.
--

commit b8d17764218e572db22388434473471ed009998c
Author: Philipp Hahn <phahn-oss@avm.de>

watchdog: Fix wrong SPDX license identifier

This commit updates the SPDX license identifier in the watchdog
documentation from GPL-2.0 to GPL-2.0-only.

> The identifier GPL-2.0 has been deprecated in favor of GPL-2.0-only.
> Change it to silence checkpatch.

Is this description accurate regarding checkpatch?

Looking at scripts/checkpatch.pl, it only enforces GPL-2.0-only for files
under Documentation/devicetree/bindings/ and include/dt-bindings/.

Additionally, LICENSES/preferred/GPL-2.0 explicitly defines GPL-2.0 as a
valid identifier in the Linux kernel.

Since checkpatch does not emit warnings for GPL-2.0 in generic subsystem
documentation like Documentation/watchdog/index.rst, does this change
introduce unnecessary churn?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1777892508.gi=
t.phahn-oss@avm.de?part=3D1

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987488;
	b=NiOzJgg+kAWY2r8dE18QYZmqDZVMTQvpaytN2ww7F2oJChBemF1fP2cVKJ7tYoCXJBkV
	 ncvCRA03XN7gRepjOjXAhF/7pSKZ0+6o4M+MYXWhEolnQ/HlhXryR9xzeeIqnm8iOwAji
	 yx1eiz9181o4PRoiOGmGxk/vaLfqrfClsyF9/4BJQ9GnWYsh6ChaXbT8/xkmiKHrzGou/
	 3etyPdv4u7+3uUGssFYxq3ul+ktLNT1L7IP+nJNIx2Zzi0olYd2gyNBZmuQap9c8C1RLl
	 F8OBIakswo1B3xwNejryBosx0wi25RNIKEtwAua65A2fdXy9ldFrc3FsNf5KWoeZtqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987488;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CI2F9MLArIPYb8o92Ao6ZqnJzPWk5Nn/LaI5FCUKs+o=;
	b=B5zaQdTBfoik2s8SghudsXiOXC2E810/wzbJrZ/2qsGa0UQyvfFCVLgp6zR9PB+wEkOd
	 O1Znu4pS8dgPN313sIVpEJm9Bw/ABZLvSJI5CY/HVjMQ0pPzGOakBHywtpFF2fY47PjTq
	 eEIcRKS4GqfxvH7AQ6pwXDVxA6PyRN2a12FZtqceEEvguvpncTaVaPaDcc7OxPmIW79kp
	 yY58Hup+tVMbobsKO3hQpHb1UnkobIN0mFNB6exd2pHSDREyJ6YeIBQcmq69lP7nRHICX
	 ttaA+KtuFefAmSWIPxQmCi0W6zDMnY8hHNfIstu1w/b8bgIq3VRBWn189bM8NP6hdvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ngJvq3md;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E754606A32C;
	Fri,  6 Nov 2026 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ngJvq3md
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF26F1F0089F;
	Fri,  6 Nov 2026 17:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793987488;
	bh=CI2F9MLArIPYb8o92Ao6ZqnJzPWk5Nn/LaI5FCUKs+o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ngJvq3md39xeGgnAMH2ZXgGxRSO8Wl/LtPW9wPZFSwhUzRWDLnp/DfNPlVFBRLmeM
	 5FkoFWKBHrcR0WkG0F3OX/eJ8eqJYfiJRkcFjVd0DwrjeCy+Qu4xjP4Mmet/GnjVEZ
	 WLdFyM4JyhPR/qafOtWUAFTdkLK0mgxoiosheSdr0GRPzYh3pXoLtiBrRdQU0CmY4f
	 6wPyR1uqCgsy+WuvqrDQpEJMmlT4c45cA0EIVxkSWS/O0luql+UsIUzpHCborIy+85
	 jIZTLwZKrewXKkSFCsxw7P+JPZu31W6m2EzWwD67FYZu76oF21tbkFUtRe2JRfQciW
	 4Zya3UlM279iQ==
Message-ID: <sashiko-outbox-201973@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/13] ARM: dts: stm32: enable arm smc watchdog on
 stm32mp15x scmi boards
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antonio Borneo" <antonio.borneo@foss.st.com>, devicetree@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261106163429.618392-9-antonio.borneo@foss.st.com>
References: <20261106163429.618392-1-antonio.borneo@foss.st.com>
 <20261106163429.618392-9-antonio.borneo@foss.st.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:51:27 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] ARM: dts: stm32: commit message references STM32MP2xx instead of
  STM32MP15x
--

commit 827293cb45c655141edc2ff759dd8058ed4045d8
Author: Amelie Delaunay <amelie.delaunay@foss.st.com>

ARM: dts: stm32: enable arm smc watchdog on stm32mp15x scmi boards

This commit enables the arm_wdt node and assigns it the watchdog0 alias on
STM32MP15x SCMI board device trees.

> With two watchdogs now enabled on ST STM32MP2xx boards, assign the
> watchdog0 alias to the ARM SMC watchdog that may have been started
> by an earlier boot stage. This allows userspace to identify and
> ping the appropriate watchdog.

[Severity: Low]
This isn't a bug, but this paragraph refers to STM32MP2xx boards rather
than the STM32MP15x SCMI boards modified by this patch.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106163429.6183=
92-1-antonio.borneo@foss.st.com?part=3D8

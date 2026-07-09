Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208E2346A19;
	Thu,  9 Jul 2026 07:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783583128; cv=none; b=KB7/7XewXlef6KiuSwPLBAA35djGeRHdNR5SR8JiaTJGgLSh40mteyXg4/CMdvECUHn6WX2YHb0H2644h3LYj2Id51INgoKq2sUu7xLDc1Xlufo3Vi4DSQczPNUz9tqzZAIQi4sGdg+Wj06mH2Ntc/b5iOIuZd8xLvSuPFYp038=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783583128; c=relaxed/simple;
	bh=40a9xpSw3CErf2kAx8upEVaBC6E+hQyGSkyO2Gw+lE8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GhhwmFDbrn2b/HT8MrGL2KkJ2OuKVso3PUUa2E93g7YRHeWmqN/6QAxzi2mVK+QlqhU/++TOhWKzjaoyk0xsoKqS66S6kn97t2GKpba4AmmXsJ3FuQrwk0ri7Kn9+O5QxaPHN4k6KsIAiJ68ngKn9cMyJbtUojKZrh4IDpRdGuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3K4b/2J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3K4b/2J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFE31F00A3A;
	Thu,  9 Jul 2026 07:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783583126;
	bh=40a9xpSw3CErf2kAx8upEVaBC6E+hQyGSkyO2Gw+lE8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R3K4b/2JGNmIVQc5aTtH+rStQryABnFVrIEF9YHHU9FxTJFKFRfGZyO4aedq9iA+c
	 vEU5yNZ7o1TgvQ02x1PbmD8ZkFEoQ1/DBLvgqlQjua5/RNrB4O1cpSDH1enV8Mk01R
	 jZgLrP/tTcu2Glk1ZsIlcw6Zao6nL8WCVn697XRQbxSwhl0MaHvnMM0VACusjPWfcT
	 Zv1hCm6phlAG3fYrLzixRJ61XY8YpkrA8Cropo5+J2pGXk8iIkqQ9RQg2OA+P+iXNl
	 9fEEqGhjt1uh3czeh5GMG69BiRXj4joBgPes2/XwaWNy0XCGRwyHytSkLjM+iOl0rl
	 UMnrG7uXSCBzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/11] dt-bindings: power: apple,pmgr-pwrstate: Add
 t6030 and t6031 compatibles
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janne Grunau" <j@jannau.net>
Cc: devicetree@vger.kernel.org, robh@kernel.org, linux-watchdog@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260709-apple-t603x-initial-devices-v1-5-55b305833123@jannau.net>
References: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
 <20260709-apple-t603x-initial-devices-v1-5-55b305833123@jannau.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 07:45:25 +0000
Message-Id: <20260709074526.7DFE31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit message contains a typographical error when listing the =
newly added compatible strings. It incorrectly claims to add '"apple,t6030-=
pmgr-pwrstate" for M3 Pro and "apple,t6030-pmgr-pwrstate" for M3 Max and Ul=
tra', repeating 't6030' instead of correctly stating that 'apple,t6031-pmgr=
-pwrstate' was added for the M3 Max and Ultra, which matches the actual pat=
ch contents.
--

--- Patch [5]: [PATCH 05/11] dt-bindings: power: apple,pmgr-pwrstate: Add t=
6030 and t6031 compatibles ---
commit a32e592d592072e4f59a9b2c56534397db2aadf2
Author: Janne Grunau <j@jannau.net>

dt-bindings: power: apple,pmgr-pwrstate: Add t6030 and t6031 compatibles

This commit adds the apple,t6030-pmgr-pwrstate and apple,t6031-pmgr-pwrstate
compatible strings for Apple M3 Pro, Max, and Ultra SoCs.

> dt-bindings: power: apple,pmgr-pwrstate: Add t6030 and t6031 compatibles
>
> The pmgr-powerstate registers on Apple M3 Pro, Max and Ultra SoCs are
> compatible with "apple,t8103-pmgr-pwrstate". Add
> "apple,t6030-pmgr-pwrstate" for M3 Pro and "apple,t6030-pmgr-pwrstate"
> for M3 Max and Ultra as per-SoC compatibles.

[Severity: Low]
This isn't a bug, but should the second compatible string mentioned in the
description be apple,t6031-pmgr-pwrstate to match the changes made in the
patch?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-apple-t603=
x-initial-devices-v1-0-55b305833123@jannau.net?part=3D5

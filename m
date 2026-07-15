Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA4C41D65C;
	Wed, 15 Jul 2026 09:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107087; cv=none; b=VBrOAroaE0u13890FKRliZIIm6lNgxzUBABx5VeU+tsvDBGPgGlkkJ64WfZMQjNOmNk6Isb5nEt5uDze5PjVqL4IM1e3gj7IvtgRrMaFz1HIIfZsP1tX5Ndu7T6bDKeQQ+yxWF8tKwiKt38MB6NhSnWE2bQ6gVMFax8ZDM5y9I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107087; c=relaxed/simple;
	bh=W8URg+6MQxwIHa3ueS6S2tn+BXkhDmp+il12nhY8l/U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u8i9psn9OXt/tEFLYe40giMxH+vELTm6U8VAyiz0eo6NvRpuSJ6dxSG4sgh8dcSAy9wPvGhRZFTvDdKdrUZ3uUSGpBhDt0mJoRjtzOjWPLQS1P8N1YoKRAS9y/aWb25oUM/0W7BQeSxAXfDThI8EzczQTiTPo1mITq5seYWAbEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5wzWDzD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5wzWDzD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661C21F000E9;
	Wed, 15 Jul 2026 09:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784107080;
	bh=W8URg+6MQxwIHa3ueS6S2tn+BXkhDmp+il12nhY8l/U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k5wzWDzD32EhqAO61Ip8h4aXV5VFTVCL4rYtC6WmzyqCmlwsUulwMwYBFvPzsm4Ql
	 emxKCgbLMDd5jkV3JY3wLSE6v+B3rnVtWuBhtNK1yeJjcufJBf7j+Dt9yCqh+hBc1/
	 xs9fRl2oCEw4Lx3SQKxR4w3MtKsGhguygkpISL3nXqVZGyaJ0IOdX8LfC8ztOtyDeM
	 UbULtyYcibslLIAMBq8bXlKs7W7sNVa1bY4prviLRcXEUJOfCfQsJaNXMvMmeX8+lU
	 nWzlU4/QrrFOGx9dFDsaNOVumHBw0S/t/kjfVZQM394+g0/sZWm/UNZa65epee7TaC
	 OHit14MrZP6Jw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/10] dt-bindings: power: apple,pmgr-pwrstate: Add
 t6030 and t6031 compatibles
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janne Grunau" <j@jannau.net>
Cc: robh@kernel.org, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260715-apple-t603x-initial-devices-v2-5-df65b2485710@jannau.net>
References: <20260715-apple-t603x-initial-devices-v2-0-df65b2485710@jannau.net>
 <20260715-apple-t603x-initial-devices-v2-5-df65b2485710@jannau.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 09:17:59 +0000
Message-Id: <20260715091800.661C21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit message incorrectly duplicates 'apple,t6030-pmgr-pwrstat=
e' when explaining the new compatible strings.
--

--- Patch [5]: [PATCH v2 05/10] dt-bindings: power: apple,pmgr-pwrstate: Ad=
d t6030 and t6031 compatibles ---
commit 0f321dd30362858c61b0d6995914cf56752d651f
Author: Janne Grunau <j@jannau.net>

dt-bindings: power: apple,pmgr-pwrstate: Add t6030 and t6031 compatibles

This commit adds "apple,t6030-pmgr-pwrstate" and "apple,t6031-pmgr-pwrstate=
"=20
compatible strings for Apple M3 Pro, Max, and Ultra SoCs.

> The pmgr-powerstate registers on Apple M3 Pro, Max and Ultra SoCs are
> compatible with "apple,t8103-pmgr-pwrstate". Add
> "apple,t6030-pmgr-pwrstate" for M3 Pro and "apple,t6030-pmgr-pwrstate"
> for M3 Max and Ultra as per-SoC compatibles.

[Severity: Low]
This isn't a bug, but there appears to be a typo in the commit message. It=
=20
duplicates "apple,t6030-pmgr-pwrstate" instead of mentioning=20
"apple,t6031-pmgr-pwrstate" for the M3 Max and Ultra.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715-apple-t603=
x-initial-devices-v2-0-df65b2485710@jannau.net?part=3D5

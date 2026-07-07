Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7462B23D7E3
	for <linux-watchdog@vger.kernel.org>; Tue,  7 Jul 2026 10:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420314; cv=none; b=I+EX6ekNNMqZx/l7vMFsVfYeg0jniJymfzA/aL/eT71rJ39Oh3GCV0ehw3mg1RcpFXzrO43blndHajmgwo1JcJ60+4YCYer49CqNyfiqTrj5sMP4M1cs7YEMKDBtZvJNhxqtwBYuSYUn0ugG0rCs8nRaQG697HiT1MDMhIzUJVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420314; c=relaxed/simple;
	bh=9HHOz0vNxBEHc/zZEzhg18nm9gVxjzqDz6KL0Yq1Hvo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CXmaT6kNzGaI6vTW0VcVj3RShTkY7/RD52DF0Cl2zdXuhapFoltGCPsjVWoCGqlhSXkEhzLZDTbWUH7cRQeRUgdWskt0LMpGyzsFHsY86IiVFX16E4J4C7jdCwqE7AqGLvxkgyqwRozrN+xGVOyuGjuZtObT6XFotLuGbyCjAWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ordUr2Bc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ordUr2Bc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DEB1F00A3A;
	Tue,  7 Jul 2026 10:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783420313;
	bh=itq/f3jQ86KXSS7kybkgAQqx2r5f7fqpNyZ5412ubHE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ordUr2BchiBDxlzU27nWLgAIJ4GSZLAXdtZXBUD2ep/JgwWyHyh3BeQMdgPOK+SMQ
	 JoRb/03f1lRezqzIsv3T6lt/FzQ/ynqT7yiU+GxeQQDTP10NxtLr5y6mLFUpGrsy/T
	 AeWxY3ZxJbucmysP/odBL+E04meU5MkFl8HkGZbuf4W0f2OxfPTepIeYw16c+dn4iS
	 7lEvnU9cmW+pBHDPFQoEgGG3Z6P5eDiAK3fxv03TqnecJgvT2mDQ+jjKkzoKSyH2o2
	 sIKtK+4vbNRU8TMtwdtOLXPdJ6Jq/JMx6qvAQFEZUazDh0yh9bZv/sIQhsBSBBoT9/
	 69rnT9l8vX2Lw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] watchdog: pretimeout: Add "dump" pretimeout governor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tzung-Bi Shih" <tzungbi@kernel.org>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260707102105.3600275-1-tzungbi@kernel.org>
References: <20260707102105.3600275-1-tzungbi@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 10:31:52 +0000
Message-Id: <20260707103152.F0DEB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unregistering the default watchdog pretimeout governor leaves dang=
ling pointers in `default_gov` and active watchdogs, leading to a Use-After=
-Free.
--

--- Patch [1]: [PATCH v2] watchdog: pretimeout: Add "dump" pretimeout gover=
nor ---
commit fdc83bdc7fe1e2cb54902870250cd46dee161270
Author: Tzung-Bi Shih <tzungbi@kernel.org>

watchdog: pretimeout: Add "dump" pretimeout governor

This patch adds a new "dump" pretimeout governor that triggers an all-CPU
backtrace on watchdog pretimeout. It also updates the Kconfig logic to
ensure the "panic" governor is selected as a fallback when others are disab=
led.

Link: https://lore.kernel.org/all/20260707073117.2962676-1-tzungbi@kernel.o=
rg

> diff --git a/drivers/watchdog/pretimeout_dump.c b/drivers/watchdog/pretim=
eout_dump.c
> new file mode 100644
> index 0000000000000..c5d3dac2606c4
> --- /dev/null
> +++ b/drivers/watchdog/pretimeout_dump.c

[ ... ]

> +static void __exit watchdog_gov_dump_unregister(void)
> +{
> +	watchdog_unregister_governor(&watchdog_gov_dump);
> +}

[Severity: High]
This is a pre-existing issue, but does unregistering a default governor lea=
ve
dangling pointers in watchdog devices?

Looking at watchdog_unregister_governor() in
drivers/watchdog/watchdog_pretimeout.c:

void watchdog_unregister_governor(struct watchdog_governor *gov)
{
    ...
    list_for_each_entry(p, &pretimeout_list, entry)
        if (p->wdd->gov =3D=3D gov)
            p->wdd->gov =3D default_gov;
    ...
}

If the governor being unregistered happens to be the current default govern=
or,
default_gov is not cleared and still points to the governor being removed. =
The
fallback assignment reassigns the same dangling pointer back to the watchdog
device.

Could this lead to a use-after-free on the next pretimeout event if the
governor's memory is freed after unregistration?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707102105.3600=
275-1-tzungbi@kernel.org?part=3D1

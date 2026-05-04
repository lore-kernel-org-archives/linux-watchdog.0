Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BFE3A2574
	for <linux-watchdog@vger.kernel.org>; Mon,  4 May 2026 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777914664; cv=none; b=hYw1FDeLPA9dIh0uXnN7WHmUW5t4Vsa7aePeMJW1bjlA863rwaUPSVW7FC41CJTg9JveD179TFYSbc8urAxsHnm13ry2856X0ir0Xgo8B0P7hM68UTkvJxX8/AYk4gfLYlrIydTMifQvWDmp4pt+475/z9mosK7NIbbdgvZ1jwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777914664; c=relaxed/simple;
	bh=n8FAkV3nUZiwfREhC/fhqzElVfsyVNxc0kPX2wZhB2g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IgD96ty9fEHxqxdmn1bzmip5ZoREM9zbrQhC+MXrKPDq6QbApJrWG2CGrJM1r+qIWqpbcDn7J70+UHq9OIBbqb16h4i//wOZpcp280euWJaMFE97nGMyAEkrykga86wQ4xiuJkxihuWGqKqB12Vc0B3Z0IVdsB7gUt8GYpc9+zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOTF9XId; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOTF9XId"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C5EC2BCB8;
	Mon,  4 May 2026 17:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777914664;
	bh=n8FAkV3nUZiwfREhC/fhqzElVfsyVNxc0kPX2wZhB2g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=gOTF9XIdNCKIQ4I20nNq5LrYcIT4NDq05HM8B1vZXC+l2Ixe3pGemNQnpEAJINcYS
	 9e+j/vyWKoFu6BwT7g88MuEKj+HZt4cPLQP48dYURgPkTHv81H5il5QbLWkJPZ090X
	 lu53/6e8cp290jR/8fl+zeSXbkk06b70zpxc1eZCJOGznyZtUTee+E2j0qBRDndAEI
	 LaLahdu0PerX5pXPP4rnxsi9epf+EWeZTxh5D3Ix+EdOktHRJfnxw56LTuhNAfcCvX
	 e5X7xWQV4zFoBJmiON4NQHgwR0a6zUp6mxjhvDgI3J0+orJbCQKgdgJ9DRraYABoTM
	 atcPcj8J219sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] watchdog: Prefix WDT with ICS for clarity
Reply-To: sashiko@lists.linux.dev
To: "Philipp Hahn" <p.hahn@avm.de>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <25e65a138f70239b6263bdfbed801f1acbb06688.1777902230.git.phahn-oss@avm.de>
References: <25e65a138f70239b6263bdfbed801f1acbb06688.1777902230.git.phahn-oss@avm.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 17:11:03 +0000
Message-Id: <20260504171103.D3C5EC2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incomplete renaming: the 'ICS' prefix was not added to the Kconfig =
help text for the WDTPCI configuration.
--

commit 4485842d9f93fd889373b4245fc0ff5cb5d3e3b8
Author: Philipp Hahn <phahn-oss@avm.de>

watchdog: Prefix WDT with ICS for clarity

The commit updates documentation and Kconfig files to clarify that WDT refe=
rs
to the Watchdog timer from Industrial Computer Source (ICS). It adds the ICS
prefix in several places and includes a missing SPDX license identifier.

> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index dc78729ba2a5d..2cbf0391a065a 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
[ ... ]
> @@ -2270,10 +2270,10 @@ config MIXCOMWD
>  	  Most people will say N.
> =20
>  config WDT
> -	tristate "WDT Watchdog timer"
> +	tristate "ICS WDT Watchdog timer"
>  	depends on ISA
>  	help
> -	  If you have a WDT500P or WDT501P watchdog board, say Y here,
> +	  If you have an ICS WDT500P or WDT501P watchdog board, say Y here,
>  	  otherwise N. It is not possible to probe for this board, which means
[ ... ]
> @@ -2304,7 +2304,7 @@ config PCIPCWATCHDOG
>  	  Most people will say N.
> =20
>  config WDTPCI
> -	tristate "PCI-WDT500/501 Watchdog timer"
> +	tristate "ICS PCI-WDT500/501 Watchdog timer"
>  	depends on PCI && HAS_IOPORT
>  	help
>  	  If you have a PCI-WDT500/501 watchdog board, say Y here, otherwise N.

This isn't a bug, but should the help text for WDTPCI also be updated to
include the ICS prefix for consistency? The WDT config help text was updated
above, but this description still reads "If you have a PCI-WDT500/501
watchdog board".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1777902230.gi=
t.phahn-oss@avm.de?part=3D5

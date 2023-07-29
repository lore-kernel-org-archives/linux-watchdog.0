Return-Path: <linux-watchdog-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57A2C0015E
	for <linux-watchdog@archiver.kernel.org>; Sat, 29 Jul 2023 10:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjG2KWL (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sat, 29 Jul 2023 06:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjG2KWK (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 29 Jul 2023 06:22:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A6D4202;
        Sat, 29 Jul 2023 03:22:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E491060B7D;
        Sat, 29 Jul 2023 10:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17586C433C8;
        Sat, 29 Jul 2023 10:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690626128;
        bh=tuPIbqBr52wBKVdl98uVAm315Bxepe8VF8Jh0dVoqb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bwhY0I23bb0OBrElDNY7q4V16m1Dk1fvyOEhfxoyucmPHcRYYvQoy355fEf6vkp1y
         SWlM2CawNSmu6LVeyHstxjcTpVkPZaeUEIeXDKlbfldqSolDua8y27o/K6Iex4n5pS
         nqQsNPzpoXm+rk1SOIWCEb1S+oo5x3ZBUk1U2bmmHoGkjY1FQ2jKlqyVQD+D++4dZD
         Rz996sqdPI0BacfTb8eEj6IAAkJNaVRbTrFERGp4R+NyQQPR0iAyEfyDZaLopEeyv8
         bCtqVflq8SMtKWagzi+7RXmP7DuKmx19c6s5+bsnysXpu0UhIBKY1ARmUDiAEj591q
         Ho7YZGgfaTYcg==
Date:   Sat, 29 Jul 2023 11:22:03 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] watchdog: Enable COMPILE_TEST for more drivers
Message-ID: <20230729-twerp-avert-70577ff7d952@spud>
References: <20230728195022.1198555-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="niFHKtW+E1+3Tf0J"
Content-Disposition: inline
In-Reply-To: <20230728195022.1198555-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org


--niFHKtW+E1+3Tf0J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 01:50:21PM -0600, Rob Herring wrote:
> There's quite a few watchdog drivers which are easily enabled for
> COMPILE_TEST, so let's enable them.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Passed allyesconfig builds on arm, arm64, x86, riscv, powerpc, sparc

Doing its job I suppose, the riscv patchwork automation stuff has
spotted one new complaint for allmodconfig:
stm32_iwdg.c:77:19: warning: unused function 'reg_read' [-Wunused-function]


--niFHKtW+E1+3Tf0J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMToSwAKCRB4tDGHoIJi
0hUuAQDTDOhDkjqpoQL8kgJdY0n07+K7LrUs4Nbwjsrj8p+LOQEA3agQW/XkUhV+
5EP8xSOUmR8kGeU3oQXbtv0VPb0kkgM=
=hMX2
-----END PGP SIGNATURE-----

--niFHKtW+E1+3Tf0J--

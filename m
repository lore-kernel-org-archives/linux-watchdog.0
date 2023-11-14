Return-Path: <linux-watchdog-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C73C4332F
	for <linux-watchdog@archiver.kernel.org>; Tue, 14 Nov 2023 09:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjKNJAr (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 14 Nov 2023 04:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjKNJAq (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 14 Nov 2023 04:00:46 -0500
Received: from mail.venturelinkbiz.com (mail.venturelinkbiz.com [51.195.119.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFA31A5
        for <linux-watchdog@vger.kernel.org>; Tue, 14 Nov 2023 01:00:41 -0800 (PST)
Received: by mail.venturelinkbiz.com (Postfix, from userid 1002)
        id 72AD846FE0; Tue, 14 Nov 2023 09:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=venturelinkbiz.com;
        s=mail; t=1699952440;
        bh=JBV4b8UUo1MSngn/QBoedt1Dv52bT8rWeq4R22MtJMs=;
        h=Date:From:To:Subject:From;
        b=tK59lQDwiECYMspUhCpeZnU2bJuZppfUMXWkwXUWCxvs+nwOYsje4myHAmBrEMQhh
         2dQmGpm/WCfPaRskeLpmMxCWyzpcOgzAXbzCke8B04THe88rflOHB8zh/yEkEpsZpa
         bKtfBXI9+OAZSf2Ok8+GOMlME0TrFe/i+TS3fExH+6g+5rZQUn2a8gYtWTPrz649kE
         td9siDueeWzQSgkNBgKmoQdEY7tYNntRxGyFMsq70YecZe/RPOwrvv39WZpFSvGkMG
         Ez+4Dmih7A1JvtG4ViQJvpIz6EkYp/Y6FjfHTVh9QYZAKg87SK3W4eZ+BBmIyVeGQM
         jn5H+QUHSGTWQ==
Received: by mail.venturelinkbiz.com for <linux-watchdog@vger.kernel.org>; Tue, 14 Nov 2023 09:00:10 GMT
Message-ID: <20231114074500-0.1.3k.9yno.0.6nj9a72rd6@venturelinkbiz.com>
Date:   Tue, 14 Nov 2023 09:00:10 GMT
From:   "Michal Rmoutil" <michal.rmoutil@venturelinkbiz.com>
To:     <linux-watchdog@vger.kernel.org>
Subject: =?UTF-8?Q?Efektivn=C3=AD_sledov=C3=A1n=C3=AD_a_optimalizace_v=C3=BDroby_pro_va=C5=A1i_spole=C4=8Dnost?=
X-Mailer: mail.venturelinkbiz.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Dobr=C3=A9 r=C3=A1no,

m=C3=A1te mo=C5=BEnost sledovat stav ka=C5=BEd=C3=A9ho stroje a v=C3=BDro=
bn=C3=ADho procesu z kancel=C3=A1=C5=99e, konferen=C4=8Dn=C3=AD m=C3=ADst=
nosti nebo dokonce z domova =C4=8Di na cest=C3=A1ch =E2=80=93 na va=C5=A1=
em telefonu?

Poskytujeme rychle implementovateln=C3=BD a snadno pou=C5=BEiteln=C3=BD n=
=C3=A1stroj, kter=C3=BD zachyt=C3=AD i n=C4=9Bkolikasekundov=C3=BD mikrop=
rostoj a okam=C5=BEit=C4=9B p=C5=99epo=C4=8D=C3=ADt=C3=A1 vyu=C5=BEit=C3=AD=
 stroje v kontextu dan=C3=A9 v=C3=BDrobn=C3=AD zak=C3=A1zky.

Kdykoli vid=C3=ADte stav objedn=C3=A1vky a jste informov=C3=A1ni o p=C5=99=
=C3=ADpadn=C3=A9m sn=C3=AD=C5=BEen=C3=AD efektivity. Syst=C3=A9m s=C3=A1m=
 analyzuje data a p=C5=99ipravuje cenn=C3=A9 reporty, co=C5=BE oper=C3=A1=
tor=C5=AFm umo=C5=BE=C5=88uje soust=C5=99edit se na v=C3=BDrobn=C3=AD c=C3=
=ADl.

C=C3=ADl je jednoduch=C3=BD: jeden pohled =E2=80=93 cel=C3=A1 tov=C3=A1rn=
a. =C4=8Cek=C3=A1m na odpov=C4=9B=C4=8F, jestli vid=C3=ADte mo=C5=BEnost =
vyu=C5=BEit=C3=AD takov=C3=A9ho n=C3=A1stroje ve va=C5=A1=C3=AD firm=C4=9B=
=2E


Pozdravy
Michal Rmoutil
